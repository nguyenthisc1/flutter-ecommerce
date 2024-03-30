import 'dart:html';

import 'package:ecommerce/data/repositories/authentication_repository.dart';
import 'package:ecommerce/data/user/user_repository.dart';
import 'package:ecommerce/features/authentication/screens/login/login.dart';
import 'package:ecommerce/features/personalization/models/user_model.dart';
import 'package:ecommerce/features/personalization/screens/profile/wigets/re_authenticate_user_login_form.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/network_manager.dart';
import 'package:ecommerce/utils/popups/full_screen_loader.dart';
import 'package:ecommerce/utils/popups/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;

  final hidePassword = true.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  // FETCH USER RECORD
  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();

      this.user(user);
      profileLoading.value = false;
    } catch (error) {
      user(UserModel.empty());
      TLoaders.warningSnackBar(
          title: 'Fetching user failed',
          message:
              'Something went wrong while saving your Information. You can re-save your data in your Profile. \n $error');
    } finally {
      profileLoading.value = false;
    }
  }

// SAVE USER RECORD ANY REGISTRATION PROVIDER
  Future<void> saveUserRecord(UserCredential? userCredential) async {
    try {
      if (userCredential != null) {
        // CONVERT NAME TO FIRST AND LAST NAME
        final nameParts =
            UserModel.nameParts(userCredential.user!.displayName ?? '');
        final username =
            UserModel.generateUserName(userCredential.user!.displayName ?? '');

        // MAP DATA
        final user = UserModel(
            id: userCredential.user!.uid,
            firstName: nameParts[0],
            lastName:
                nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
            userName: username,
            email: userCredential.user!.email ?? '',
            phoneNumber: userCredential.user!.phoneNumber ?? '',
            profilePicture: userCredential.user!.photoURL ?? '');

        // SAVE USER
        await userRepository.saveUserRecord(user);
      }
    } catch (error) {
      TLoaders.warningSnackBar(
          title: 'Data not saved',
          message:
              'Something went wrong while saving your Information. You can re-save your data in your Profile. \n $error');
    }
  }

  // DELETE ACCOUNT WARNING
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
        contentPadding: const EdgeInsets.all(TSizes.md),
        title: 'Delete Account',
        middleText:
            'Are you sure want to delete account permanently? This action is not reversible and all of your data all will be removed permanently.',
        confirm: ElevatedButton(
          onPressed: () async => deleteUserAccount(),
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              side: const BorderSide(color: Colors.red)),
          child: const Text('Delete'),
        ),
        cancel: OutlinedButton(
          onPressed: () => Navigator.of(Get.overlayContext!).pop(),
          child: const Text('Cancel'),
        ));
  }

  // DELETE USER ACCOUNT
  void deleteUserAccount() async {
    try {
      // START LOADING
      TFullScreenLoader.openLoadingDialog('Processing', TImages.docerAnimation);

      // FIRST RE-AUTHENTICATE USER
      final auth = AuthenticationRepository.instance;
      final provider =
          auth.authUser!.providerData.map((e) => e.providerId).first;
      if (provider.isNotEmpty) {
        // RE VERIFY AUTH EMAIL
        if (provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          TFullScreenLoader.stopLoading();
          Get.offAll(() => const LoginScreen());
        } else if (provider == 'password') {
          TFullScreenLoader.stopLoading();
          Get.to(() => const ReAuthLoginForm());
        }
      }
    } catch (error) {
      // REMOVE LOADER
      TFullScreenLoader.stopLoading();

      // SHOW ERROR
      TLoaders.warningSnackBar(
          title: 'Delete fail!', message: 'Something went wrong. \n $error');
    }
  }

  // RE-AUTHENTICATE BEFORE DELETING
  Future<void> reAuthenticateEmailAndPasswordUser() async {
    try {
      // START LOADING
      TFullScreenLoader.openLoadingDialog('Processing', TImages.docerAnimation);

      // CHECK INTERNET CONNECTIVITY;
      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // FORM VALIDATION
      if (!reAuthFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance.reAuthenticateEmailAndPassword(
          verifyEmail.text.trim(), verifyPassword.text.trim());
      await AuthenticationRepository.instance.deleteAccount();
      TFullScreenLoader.stopLoading();

      Get.offAll(() => const LoginScreen());
    } catch (error) {
      // REMOVE LOADER
      TFullScreenLoader.stopLoading();

      // SHOW ERROR
      TLoaders.warningSnackBar(
          title: 'Verify fail!', message: 'Something went wrong. \n $error');
    }
  }
}
