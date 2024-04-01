
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TFirebaseStorageService extends GetxController {
  static TFirebaseStorageService get instance => Get.find();

  // VARIABLES
  final _firebaseStorage = FirebaseStorage.instance;

  // UPLOAD LOCAL ASSETS FROM IDE
  // RETURNS A UNIT8LIST CONTAINING IMAGE DATA
  Future<Uint8List> getImageDataFromAssets(String path) async {
    try {
      final byteData = await rootBundle.load(path);
      final imageData = byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
      return imageData;
    } catch (error) {
      throw 'Error loading image data \n $error';
    }
  }

  Future<String> uploadImageData(
      String path, Uint8List image, String name) async {
    try {
      final ref = _firebaseStorage.ref(path).child(name);
      await ref.putData(image);
      final url = await ref.getDownloadURL();
      return url;
    } catch (error) {
      throw 'Error upload image data \n $error';
    }
  }
}
