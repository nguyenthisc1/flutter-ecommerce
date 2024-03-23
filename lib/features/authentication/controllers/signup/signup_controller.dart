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
  final email = TextEditingController();
  final lastName = TextEditingController();
  final fistName = TextEditingController();
  final userName = TextEditingController();
  final password = TextEditingController();
  final phoneNumber = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  // SIGNUP
  Future<void> signup() async {
    try {
      // START LOADING
      TFullScreenLoader.openLoadingDialog(
          'We are processing your information', TImages.docerAnimation);

      // CHECK INTERNET CONNECTIVITY;
      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) return;

      // FORM VALIDATION
      if (!signupFormKey.currentState!.validate()) return;
    } catch (error) {
      // SHOW ERROR
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: error.toString());
    } finally {
      // REMOVE LOADER
      TFullScreenLoader.stopLoading();
    }
    ;
  }
}
