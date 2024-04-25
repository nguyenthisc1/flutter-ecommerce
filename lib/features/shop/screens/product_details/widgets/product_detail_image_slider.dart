import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/custom_shapes/cuved_edges/cuved_edeges_widget.dart';
import 'package:ecommerce/common/widgets/icon/circular_icon.dart';
import 'package:ecommerce/common/widgets/image/rounded_image.dart';
import 'package:ecommerce/features/shop/controllers/product/product_images_controller.dart';
import 'package:ecommerce/features/shop/models/product_model.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TProductImageSlider extends StatelessWidget {
  const TProductImageSlider({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductImagesController());
    final images = controller.getAllProductImages(product);
    final dark = THelperFunctions.isDarkMode(context);

    return TCurvedEdgesWidget(
      child: Container(
        color: dark ? TColors.darkerGrey : TColors.light,
        child: Stack(children: [
          // MAIN LARGE IMAGE
          SizedBox(
              height: 400,
              child: Center(
                child: Padding(
                    padding: const EdgeInsets.all(TSizes.productImageRadius),
                    child: Obx(() {
                      final image = controller.selectedProductImages.value;
                      return GestureDetector(
                        onTap: () => controller.showEnlargedImage(image),
                        child: CachedNetworkImage(
                            imageUrl: image,
                            progressIndicatorBuilder: (_, __, downloadProgress) => CircularProgressIndicator(
                                  value: downloadProgress.progress,
                                  color: TColors.primary,
                                )),
                      );
                    })),
              )),

          // IMAGE SLIDER
          Positioned(
            left: TSizes.defaultSpace,
            bottom: 30,
            child: SizedBox(
              height: 80,
              child: ListView.separated(
                  separatorBuilder: (_, __) => const SizedBox(
                        width: TSizes.spaceBtwItems,
                      ),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: images.length,
                  itemBuilder: (_, index) => Obx(() {
                        final imagesSelected = controller.selectedProductImages.value == images[index];
                        return TRoundedImage(
                            onPressed: () => controller.selectedProductImages.value = images[index],
                            width: 80,
                            isNetworkImage: true,
                            backgroundColor: dark ? TColors.dark : const Color.fromARGB(255, 34, 26, 26),
                            border: Border.all(color: imagesSelected ? TColors.primary : Colors.transparent),
                            padding: const EdgeInsets.all(TSizes.sm),
                            imageUrl: images[index]);
                      })),
            ),
          ),

          // APPBAR ICON
          const TAppbar(
            showBackArrow: true,
            actions: [
              TCircularIcon(
                icon: Iconsax.heart5,
                color: Colors.red,
              )
            ],
          )
        ]),
      ),
    );
  }
}
