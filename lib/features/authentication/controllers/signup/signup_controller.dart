import 'package:ecommerce/data/repositories/authentication/authentication_repository.dart';
import 'package:ecommerce/data/repositories/user/user_repository.dart';
import 'package:ecommerce/features/authentication/screens/signup/verify_email.dart';
import 'package:ecommerce/features/personalization/models/user_model.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/helpers/network_manager.dart';
import 'package:ecommerce/utils/popups/full_screen_loader.dart';
import 'package:ecommerce/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  // VARIABLES
  final hidePassword = true.obs;
  final privacyPolicy = true.obs;
  final email = TextEditingController();
  final lastName = TextEditingController();
  final firstName = TextEditingController();
  final userName = TextEditingController();
  final password = TextEditingController();
  final phoneNumber = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  // SIGNUP
  void signup() async {
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
      if (!signupFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // PRIVACY POLICY CHECK
      if (!privacyPolicy.value) {
        TLoaders.warningSnackBar(
          title: 'Accept Privacy Polity',
          message:
              'In order to create account, you must have to read and accept the Privacy Polity & Terms of use',
        );
        return;
      }

      // REGISTER USER IN THE FIREBASE AUTHENTICATION & SAVE DATE IN THE FIREBASE
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());

      // SAVE AUTHENTICATED USER DATA IN THE FIREBASE FIRESTORE
      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        userName: userName.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      // REMOVE LOADER
      TFullScreenLoader.stopLoading();

      // // SHOW SUCCESS MESSAGE
      TLoaders.successSnackBar(
          title: 'Congratulation',
          message: 'Your account has been created! Verify email to continue');

      // MOVE TO VERIFY EMAIL
      Get.to(() => VerifyEmailScreen(email: email.text.trim()));
    } catch (error) {
      // REMOVE LOADER
      TFullScreenLoader.stopLoading();

      // SHOW ERROR
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: error.toString());
    }
  }
}
