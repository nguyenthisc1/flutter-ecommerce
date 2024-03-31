import 'package:ecommerce/app.dart';
import 'package:ecommerce/data/repositories/authentication/authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'firebase_options.dart';

Future<void> main() async {
  // WIDGETS BINDING
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  // GETX LOCAL STORAGE
  await GetStorage.init();

  // .ENV
  await dotenv.load();

  // AWAIT SPLASH UNTIL OTHER ITEMS LOAD
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // INITIALIZE FIREBASE
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((FirebaseApp value) => Get.put(AuthenticationRepository()));

  runApp(const App());
}
