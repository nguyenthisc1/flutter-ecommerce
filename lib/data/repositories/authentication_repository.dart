import 'package:ecommerce/features/authentication/screens/login/login.dart';
import 'package:ecommerce/features/authentication/screens/onboarding/onboarding.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  // VARIABLES
  final deviceStore = GetStorage();

  // CALLED FROM MAIN.DART ON APP LAUNCH
  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  // FUNCTION TO SHOW RELEVANT SCREEN
  screenRedirect() async {
    // LOCAL STORAGE
    if (kDebugMode) {
      print('================ GET STORAGE AUTH REPO ================');
      print(deviceStore.read('isFirstTime'));
    }

    deviceStore.writeIfNull('isFirstTime', true);
    deviceStore.read('isFirstTime') != true
        ? Get.offAll(() => const LoginScreen())
        : Get.offAll(() => const OnboardingScreen());
  }
}
