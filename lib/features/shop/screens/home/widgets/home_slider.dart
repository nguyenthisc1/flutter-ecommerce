import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/common/shimmers/shimmer_effect.dart';
import 'package:ecommerce/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:ecommerce/common/widgets/image/rounded_image.dart';
import 'package:ecommerce/features/shop/controllers/banner_controller.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TPromoSlider extends StatelessWidget {
  const TPromoSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());
    return Obx(() {
      // LOADING
      if (controller.isLoading.value) return const TShimmerEffect(width: double.infinity, height: 100);

      // NO DATA FOUND
      if (controller.banners.isEmpty) {
        return const Center(child: Text('No Data Found!'));
      } else {
        return Column(
          children: [
            CarouselSlider(
                items: controller.banners
                    .map(
                      (banner) => TRoundedImage(imageUrl: banner.imageUrl, isNetworkImage: true, onPressed: () => Get.toNamed(banner.targetScreen)),
                    )
                    .toList(),
                options: CarouselOptions(
                  viewportFraction: 1,
                  onPageChanged: (index, _) => controller.updatePageIndicator(index),
                )),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),

            // CIRCULAR
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < controller.banners.length; i++)
                    TCircularContainer(width: 20, height: 5, margin: const EdgeInsets.only(right: 10), backgroundColor: controller.carousalCurrentIndex.value == i ? TColors.primary : TColors.grey),
                ],
              ),
            )
          ],
        );
      }
    });
  }
}
