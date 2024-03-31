import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/data/repositories/authentication/authentication_repository.dart';
import 'package:ecommerce/features/personalization/models/user_model.dart';
import 'package:ecommerce/utils/exceptions/firebase_exceptions.dart';
import 'package:ecommerce/utils/exceptions/format_exceptions.dart';
import 'package:ecommerce/utils/exceptions/platform_exceptions.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // FUNCTION TO SAVE USER DATA TO FIRESTORE
  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection('Users').doc(user.id).set(user.toJson());
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

  // FETCH DATA USER ON USER ID
  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapshot = await _db
          .collection('Users')
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
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

  // UPDATE USER DATA IN FIRESTORE
  Future<void> updateUserDetails(UserModel updatedUser) async {
    try {
      await _db
          .collection('Users')
          .doc(updatedUser.id)
          .update(updatedUser.toJson());
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

  // UPDATE ANY FIELD IN SPECIFIC USER DATA COLLECTION
  Future<void> updateSingleFieldUser(Map<String, dynamic> json) async {
    try {
      await _db
          .collection('Users')
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .update(json);
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

  // REMOVE USER DATA FROM FIRESTORE
  Future<void> removeUserRecord(String userId) async {
    try {
      await _db.collection('Users').doc(userId).delete();
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

  // UPLOAD IMAGE
  Future<String> uploadImage(String path, XFile image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    } on TFirebaseException catch (error) {
      throw TFirebaseException(error.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (error) {
      throw TPlatformException(error.code).message;
    } catch (error) {
      throw 'Something went wrong, Please try again \n $error';
    }
  }
}
