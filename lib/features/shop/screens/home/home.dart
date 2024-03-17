import 'package:ecommerce/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:ecommerce/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:ecommerce/common/widgets/layout/grid_layout.dart';
import 'package:ecommerce/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:ecommerce/common/widgets/texts/search_heading.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/features/shop/screens/all_products/all_products.dart';
import 'package:ecommerce/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:ecommerce/features/shop/screens/home/widgets/home_categories.dart';
import 'package:ecommerce/features/shop/screens/home/widgets/home_slider.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const TPrimaryHeaderContainer(
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

                SizedBox(height: TSizes.spaceBtwSections),

                // CATEGORIES
                TSearchHeading(
                  title: 'Popular Categories',
                  buttonTitle: "Button",
                  showActionButton: false,
                  textColor: TColors.white,
                ),

                SizedBox(height: TSizes.spaceBtwItems),

                // CATEGORIES
                THomeCategories(),

                SizedBox(height: TSizes.spaceBtwSections),
              ]),
            ),

            // BODY
            Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: Column(
                  children: [
                    const TPromoSlider(
                      banners: [
                        TImages.promoBanner1,
                        TImages.promoBanner2,
                        TImages.promoBanner3,
                      ],
                    ),

                    const SizedBox(height: TSizes.spaceBtwSections),

                    // HEADING
                    TSectionHeading(
                        title: "Popular Products",
                        onPressed: () =>
                            Get.to(() => const AllProductsScreen())),

                    const SizedBox(height: TSizes.spaceBtwItems),

                    // PRODUCTS
                    TGridLayout(
                      itemCount: 3,
                      itemBuilder: (_, index) => const TProductCardVertical(),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
