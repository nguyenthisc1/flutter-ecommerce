import 'package:ecommerce/data/repositories/authentication_repository.dart';
import 'package:ecommerce/features/personalization/controllers/user_controller.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/helpers/network_manager.dart';
import 'package:ecommerce/utils/popups/full_screen_loader.dart';
import 'package:ecommerce/utils/popups/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  // VARIABLES
  final hidePassword = true.obs;
  final rememberMe = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final userController = Get.put(UserController());

  @override
  void onInit() {
    if (localStorage.read('REMEMBER_ME_EMAIL') != null &&
        localStorage.read('REMEMBER_ME_password') != null) {
      email.text = localStorage.read('REMEMBER_ME_EMAIL');
      password.text = localStorage.read('REMEMBER_ME_password');
    }

    super.onInit();
  }

  // SIGN-IN WIDTH EMAIL AND PASSWORD
  Future<void> emailAndPasswordSignIn() async {
    try {
      // START LOADING
      TFullScreenLoader.openLoadingDialog(
          'We are processing your information...', TImages.docerAnimation);

      // CHECK INTERNET CONNECTIVITY;
      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // FORM VALIDATION
      if (!loginFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // SAVE DATE IF REMEMBER ME IS SELECTED
      if (rememberMe.value) {
        localStorage.write("REMEMBER_ME_EMAIL", email.text.trim());
        localStorage.write("REMEMBER_ME_password", password.text.trim());
      }

      // LOGIN USER USING EMAIL & PASSWORD AUTHENTICATION
      final userCredential = await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      // REMOVE LOADER
      TFullScreenLoader.stopLoading();

      // REDIRECT
      AuthenticationRepository.instance.screenRedirect();
    } catch (error) {
      // REMOVE LOADER
      TFullScreenLoader.stopLoading();

      // SHOW ERROR
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: error.toString());
    }
  }

  // SIGN-IN WITH GOOGLE
  Future<void> googleSignIn() async {
    try {
      // START LOADING
      TFullScreenLoader.openLoadingDialog(
          'Logging you in...', TImages.docerAnimation);

      // CHECK INTERNET CONNECTIVITY;
      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // GOOGLE AUTHENTICATION
      final userCredentials =
          await AuthenticationRepository.instance.signInWithGoogle();

      // SAVE USER RECORD
      await userController.saveUserRecord(userCredentials);

      // REMOVE LOADER
      TFullScreenLoader.stopLoading();

      // REDIRECT
      AuthenticationRepository.instance.screenRedirect();
    } catch (error) {
      // REMOVE LOADER
      TFullScreenLoader.stopLoading();

      // SHOW ERROR
      TLoaders.errorSnackBar(title: 'Oh snap!', message: error.toString());
      print(error.toString());
    }
  }
}
