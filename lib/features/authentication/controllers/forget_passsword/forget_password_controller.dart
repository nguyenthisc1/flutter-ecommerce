import 'package:ecommerce/data/repositories/authentication/authentication_repository.dart';
import 'package:ecommerce/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/helpers/network_manager.dart';
import 'package:ecommerce/utils/popups/full_screen_loader.dart';
import 'package:ecommerce/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  // VARIABLES
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  // SEND EMAIL PASSWORD EMAIL
  sendPasswordResetEmail() async {
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

      await AuthenticationRepository.instance
          .sendPasswordResetEmail(email.text.trim());

      // REMOVE LOADER
      TFullScreenLoader.stopLoading();

      // // SHOW SUCCESS MESSAGE
      TLoaders.successSnackBar(
          title: 'Email sent',
          message: 'Email link sent to reset your Password'.tr);

      // REDIRECT
      Get.to(() => ResetPasswordScreen(email: email.text.trim()));
    } catch (error) {
      // REMOVE LOADER
      TFullScreenLoader.stopLoading();

      // SHOW ERROR
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: error.toString());
    }
  }

  // SEND EMAIL PASSWORD EMAIL
  resendPasswordResetEmail(String email) async {
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

      // FORM VALIDATION
      if (!forgetPasswordFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance.sendPasswordResetEmail(email);

      // REMOVE LOADER
      TFullScreenLoader.stopLoading();

      // // SHOW SUCCESS MESSAGE
      TLoaders.successSnackBar(
          title: 'Email sent',
          message: 'Email link sent to reset your Password'.tr);
    } catch (error) {
      // REMOVE LOADER
      TFullScreenLoader.stopLoading();

      // SHOW ERROR
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: error.toString());
    }
  }
}
