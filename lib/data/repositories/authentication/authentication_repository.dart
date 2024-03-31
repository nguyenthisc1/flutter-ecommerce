import 'package:ecommerce/data/repositories/user/user_repository.dart';
import 'package:ecommerce/features/authentication/screens/login/login.dart';
import 'package:ecommerce/features/authentication/screens/onboarding/onboarding.dart';
import 'package:ecommerce/features/authentication/screens/signup/verify_email.dart';
import 'package:ecommerce/navigation_menu.dart';
import 'package:ecommerce/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:ecommerce/utils/exceptions/firebase_exceptions.dart';
import 'package:ecommerce/utils/exceptions/format_exceptions.dart';
import 'package:ecommerce/utils/exceptions/platform_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();
  final _auth = FirebaseAuth.instance;

  // GET AUTHENTICATION USER DATA
  User? get authUser => _auth.currentUser;

  // CHECK DEVICE WEB
  final bool kIsWeb = const bool.fromEnvironment('dart.library.js_util');

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
    final user = _auth.currentUser;
    if (user != null) {
      if (user.emailVerified) {
        Get.offAll(() => const NavigationMenu());
      } else {
        Get.offAll(() => VerifyEmailScreen(email: _auth.currentUser?.email));
      }
    } else {
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

  // EMAIL & PASSWORD SIGN-IN
  // SIGN-IN
  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on TFirebaseAuthException catch (error) {
      throw TFirebaseAuthException(error.code).message;
    } on TFirebaseException catch (error) {
      throw TFirebaseException(error.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (error) {
      throw TPlatformException(error.code).message;
    } catch (error) {
      throw 'Something went wrong, Please try again';
    }
  }

  // SIGN-IN WITH GOOGLE
  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? userAccount = await GoogleSignIn(
              clientId: kIsWeb
                  ? dotenv.env['GOOGLE_WEB_CLIENT_ID']
                  : dotenv.env['GOOGLE_APP_CLIENT_ID'])
          .signIn();

      // OBTAIN THE AUTH DETAILS FROM THE REQUEST
      final GoogleSignInAuthentication? googleAuth =
          await userAccount?.authentication;

      // CREATE A NEW CREDENTIAL
      final credentials = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      // ONCE SIGN IN, RETURN THE CREDENTIAL
      return await _auth.signInWithCredential(credentials);
    } on TFirebaseAuthException catch (error) {
      throw TFirebaseAuthException(error.code).message;
    } on TFirebaseException catch (error) {
      throw TFirebaseException(error.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (error) {
      throw TPlatformException(error.code).message;
    } catch (error) {
      throw 'Something went wrong, Please try again';
    }
  }

  // REGISTER
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on TFirebaseAuthException catch (error) {
      throw TFirebaseAuthException(error.code).message;
    } on TFirebaseException catch (error) {
      throw TFirebaseException(error.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (error) {
      throw TPlatformException(error.code).message;
    } catch (error) {
      throw 'Something went wrong, Please try again';
    }
  }

  // MAIL VERIFICATION
  Future<void> sendEmailVerification() async {
    try {
      return await _auth.currentUser?.sendEmailVerification();
    } on TFirebaseAuthException catch (error) {
      throw TFirebaseAuthException(error.code).message;
    } on TFirebaseException catch (error) {
      throw TFirebaseException(error.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (error) {
      throw TPlatformException(error.code).message;
    } catch (error) {
      throw 'Something went wrong, Please try again';
    }
  }

  // FORGET PASSWORD
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } on TFirebaseAuthException catch (error) {
      throw TFirebaseAuthException(error.code).message;
    } on TFirebaseException catch (error) {
      throw TFirebaseException(error.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (error) {
      throw TPlatformException(error.code).message;
    } catch (error) {
      throw 'Something went wrong, Please try again';
    }
  }

  // LOGOUT
  Future<void> logout() async {
    try {
      // await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const LoginScreen());
    } on TFirebaseAuthException catch (error) {
      throw TFirebaseAuthException(error.code).message;
    } on TFirebaseException catch (error) {
      throw TFirebaseException(error.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (error) {
      throw TPlatformException(error.code).message;
    } catch (error) {
      throw 'Something went wrong, Please try again';
    }
  }

  // DELETE ACCOUNT
  Future<void> deleteAccount() async {
    try {
      await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
    } on TFirebaseAuthException catch (error) {
      throw TFirebaseAuthException(error.code).message;
    } on TFirebaseException catch (error) {
      throw TFirebaseException(error.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (error) {
      throw TPlatformException(error.code).message;
    } catch (error) {
      throw 'Something went wrong, Please try again';
    }
  }

  // RE-AUTHENTICATE BEFORE DELETING
  Future<void> reAuthenticateEmailAndPassword(
      String email, String password) async {
    try {
      // CREATE A CREDENTIAL
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: password);

      // RE-AUTHENTICATE
      await _auth.currentUser!.reauthenticateWithCredential(credential);
    } on TFirebaseAuthException catch (error) {
      throw TFirebaseAuthException(error.code).message;
    } on TFirebaseException catch (error) {
      throw TFirebaseException(error.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (error) {
      throw TPlatformException(error.code).message;
    } catch (error) {
      throw 'Something went wrong, Please try again';
    }
  }
}
