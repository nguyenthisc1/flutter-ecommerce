import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/features/shop/models/product_model.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductImagesController extends GetxController {
  static ProductImagesController get instance => Get.find();

  // VARIABLES
  RxString selectedProductImages = ''.obs;

  // GET ALL IMAGES FROM PRODUCT AND VARIATION
  List<String> getAllProductImages(ProductModel product) {
    // USE SET TO ADD UNIQUE IMAGES ONLY
    Set<String> images = {};

    // LOAD THUMBNAIL IMAGE
    images.add(product.thumbnail);

    // ASSIGN THUMBNAIL AS SELECTED IMAGE
    selectedProductImages.value = product.thumbnail;

    // GET ALL IMAGES FROM THE PRODUCT MODEL IF NOT NULL
    if (product.images != null) {
      images.addAll(product.images!);
    }

    // GET ALL IMAGES FROM THE PRODUCT VARIATIONS IF NOT NULL
    if (product.productVariation != null || product.productVariation!.isNotEmpty) {
      images.addAll(product.productVariation!.map((variation) => variation.image));
    }

    return images.toList();
  }

  // SHOW IMAGE POPUP
  void showEnlargedImage(String image) {
    Get.to(
        fullscreenDialog: true,
        () => Dialog.fullscreen(
              child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: TSizes.defaultSpace * 2, horizontal: TSizes.defaultSpace),
                  child: CachedNetworkImage(imageUrl: image),
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: 150,
                    child: OutlinedButton(onPressed: () => Get.back(), child: const Text('Close')),
                  ),
                )
              ]),
            ));
  }
}
