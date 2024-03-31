import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/data/services/firebase_storage_service.dart';
import 'package:ecommerce/features/shop/models/category_model.dart';
import 'package:ecommerce/utils/exceptions/firebase_exceptions.dart';
import 'package:ecommerce/utils/exceptions/platform_exceptions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  // VARIABLES
  final _db = FirebaseFirestore.instance;

  // GET ALL CATEGORIES
  Future<List<CategoryModel>> fetchCategories() async {
    try {
      final snapshot = await _db.collection('Categories').get();
      final list = snapshot.docs.map((document) => CategoryModel.fromSnapshot(document)).toList();
      return list;
    } on TFirebaseException catch (error) {
      throw TFirebaseException(error.code).message;
    } on PlatformException catch (error) {
      throw TPlatformException(error.code).message;
    } catch (error) {
      throw 'Something went wrong. \n $error';
    }
  }

  // GET SUB CATEGORIES

  // UPLOAD CATEGORIES TO THE CLOUD FIREBASE
  Future<void> uploadDummyData(List<CategoryModel> categories) async {
    try {
      // UPLOAD ALL THE CATEGORIES ALONG WITH THEIR IMAGES
      final storage = Get.put(TFirebaseStorageService());
      // LOOP THROUGH EACH CATEGORY
      for (var category in categories) {
        // GET IMAGE DATA LINK FROM THE LOCAL ASSETS
        final file = await storage.getImageDataFromAssets(category.image);

        // UPLOAD IMAGE AND GET ITS URL
        final url = await storage.uploadImageData('Categories', file, category.name);

        // ASSIGN URL TO CATEGORY. IMAGE ATTRIBUTE
        category.image = url;

        // STORAGE CATEGORY IN FIRESTORE
        await _db.collection('Categories').doc(category.id).set(category.toJson());
      }
    } on TFirebaseException catch (error) {
      throw TFirebaseException(error.code).message;
    } on PlatformException catch (error) {
      throw TPlatformException(error.code).message;
    } catch (error) {
      throw 'Something went wrong. \n $error';
    }
  }
}
