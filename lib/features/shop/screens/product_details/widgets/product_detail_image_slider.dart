import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/custom_shapes/cuved_edges/cuved_edeges_widget.dart';
import 'package:ecommerce/common/widgets/icon/circular_icon.dart';
import 'package:ecommerce/common/widgets/image/rounded_image.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TProductImageSlider extends StatelessWidget {
  const TProductImageSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return TCurvedEdgesWidget(
      child: Container(
        color: dark ? TColors.darkerGrey : TColors.light,
        child: Stack(children: [
          // MAIN LARGE IMAGE
          const SizedBox(
              height: 400,
              child: Center(
                  child: Padding(
                padding: EdgeInsets.all(TSizes.productImageRadius),
                child: Image(image: AssetImage(TImages.productImage1)),
              ))),

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
                  itemCount: 4,
                  itemBuilder: (_, idx) => TRoundedImage(
                      width: 80,
                      backgroundColor: dark
                          ? TColors.dark
                          : const Color.fromARGB(255, 34, 26, 26),
                      border: Border.all(color: TColors.primary),
                      padding: const EdgeInsets.all(TSizes.sm),
                      imageUrl: TImages.productImage1)),
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
