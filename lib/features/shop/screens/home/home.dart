import 'package:ecommerce/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:ecommerce/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:ecommerce/features/shop/screens/home/widgets/home_categories.dart';
import 'package:ecommerce/features/shop/screens/home/widgets/home_slider.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TPrimaryHeaderContainer(
              child: Column(children: [
                // APPBAR
                THomeAppbar(),

                SizedBox(
                  height: TSizes.spaceBtwSections,
                ),

                // SEARCH BAR
                TSearchContainer(
                  text: 'Search in Store',
                  icon: Iconsax.search_normal,
                ),

                SizedBox(
                  height: TSizes.spaceBtwSections,
                ),

                // CATEGORIES
                TSearchHeading(
                  title: 'Popular Categories',
                  buttonTitle: "Button",
                  showActionButton: false,
                  textColor: TColors.white,
                ),

                SizedBox(
                  height: TSizes.spaceBtwItems,
                ),

                // CATEGORIES
                THomeCategories()
              ]),
            ),

            // BODY
            Padding(
                padding: EdgeInsets.all(TSizes.defaultSpace),
                child: TPromoSlider(
                  banners: [
                    TImages.promoBanner1,
                    TImages.promoBanner2,
                    TImages.promoBanner3,
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
