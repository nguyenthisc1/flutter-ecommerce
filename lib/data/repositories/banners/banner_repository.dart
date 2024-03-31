import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/data/services/firebase_storage_service.dart';
import 'package:ecommerce/features/shop/models/banner_model.dart';
import 'package:ecommerce/utils/exceptions/firebase_exceptions.dart';
import 'package:ecommerce/utils/exceptions/platform_exceptions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find();

  // VARIABLES
  final _db = FirebaseFirestore.instance;

  // GET ALL BANNERS
  Future<List<BannerModel>> fetchBanners() async {
    try {
      final snapshot = await _db.collection('Banners').where('Active', isEqualTo: true).get();
      final list = snapshot.docs.map((document) => BannerModel.fromSnapshot(document)).toList();
      return list;
    } on TFirebaseException catch (error) {
      throw TFirebaseException(error.code).message;
    } on PlatformException catch (error) {
      throw TPlatformException(error.code).message;
    } catch (error) {
      throw 'Something went wrong. \n $error';
    }
  }

  // UPLOAD CATEGORIES TO THE CLOUD FIREBASE
  Future<void> uploadDummyData(List<BannerModel> banners) async {
    try {
      // UPLOAD ALL THE CATEGORIES ALONG WITH THEIR IMAGES
      final storage = Get.put(TFirebaseStorageService());
      // LOOP THROUGH EACH CATEGORY
      for (var banner in banners) {
        // GET IMAGE DATA LINK FROM THE LOCAL ASSETS
        final file = await storage.getImageDataFromAssets(banner.imageUrl);

        // UPLOAD IMAGE AND GET ITS URL
        final url = await storage.uploadImageData('Banners', file, banner.imageUrl);

        // ASSIGN URL TO CATEGORY. IMAGE ATTRIBUTE
        banner.imageUrl = url;

        // STORAGE CATEGORY IN FIRESTORE
        await _db.collection('Banners').doc(banner.imageUrl).set(banner.toJson());
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
