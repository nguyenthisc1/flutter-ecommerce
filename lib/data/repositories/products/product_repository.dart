import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/data/services/firebase_storage_service.dart';
import 'package:ecommerce/features/shop/models/product_model.dart';
import 'package:ecommerce/utils/constants/enums.dart';
import 'package:ecommerce/utils/exceptions/firebase_exceptions.dart';
import 'package:ecommerce/utils/exceptions/platform_exceptions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  // VARIABLES
  final _db = FirebaseFirestore.instance;

  // GET FEATURED PRODUCTS
  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      final snapshot = await _db.collection('Products').where('IsFeatured', isEqualTo: true).limit(4).get();
      final list = snapshot.docs.map((document) => ProductModel.fromSnapshot(document)).toList();
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
  Future<void> uploadDummyData(List<ProductModel> products) async {
    try {
      // UPLOAD ALL THE IMAGE ALONG WITH THEIR IMAGES
      final storage = Get.put(TFirebaseStorageService());
      // LOOP THROUGH EACH IMAGE
      for (var product in products) {
        // GET IMAGE DATA LINK FROM THE LOCAL ASSETS
        final thumbnail = await storage.getImageDataFromAssets(product.thumbnail);

        // UPLOAD IMAGE AND GET ITS URL
        final url = await storage.uploadImageData('Products/Images', thumbnail, product.thumbnail.toString());

        // ASSIGN URL TO THUMBNAIL. IMAGE ATTRIBUTE
        product.thumbnail = url;

        // STORAGE IMAGE IN FIRESTORE
        if (product.images != null && product.images!.isNotEmpty) {
          List<String> imageUrl = [];
          for (var image in product.images!) {
            // GET IMAGE DATA LINK FROM THE LOCAL ASSETS
            final assetImage = await storage.getImageDataFromAssets(image);

            // UPLOAD IMAGE AND GET ITS UR
            final url = await storage.uploadImageData('Products/Images', assetImage, image);

            // ASSIGN URL TO THUMBNAIL. IMAGE ATTRIBUTE
            imageUrl.add(url);
          }

          product.images!.clear();
          product.images!.addAll(imageUrl);
        }

        // UPLOAD VARIATION IMAGES
        if (product.productType == ProductType.variable.toString()) {
          for (var variation in product.productVariation!) {
            // GET IMAGE DATA LINK FROM THE LOCAL ASSETS
            final assetImage = await storage.getImageDataFromAssets(variation.image);

            // UPLOAD IMAGE AND GET ITS UR
            final url = await storage.uploadImageData('Products/Images', assetImage, variation.image);

            // ASSIGN URL TO THUMBNAIL. IMAGE ATTRIBUTE
            variation.image = url;
          }
        }

        // STORE PRODUCT IN FIREBASE
        await _db.collection('Products').doc(product.id).set(product.toJson());
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
