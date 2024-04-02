import 'package:ecommerce/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:ecommerce/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:ecommerce/common/widgets/layout/grid_layout.dart';
import 'package:ecommerce/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:ecommerce/common/widgets/shimmers/vertial_product_shimmer.dart';
import 'package:ecommerce/common/widgets/texts/search_heading.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/features/shop/controllers/product_controller.dart';
import 'package:ecommerce/features/shop/screens/all_products/all_products.dart';
import 'package:ecommerce/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:ecommerce/features/shop/screens/home/widgets/home_categories.dart';
import 'package:ecommerce/features/shop/screens/home/widgets/home_slider.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
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
                Padding(
                  padding: EdgeInsets.only(left: TSizes.defaultSpace),
                  child: THomeCategories(),
                ),

                SizedBox(height: TSizes.spaceBtwSections),
              ]),
            ),

            // BODY
            Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: Column(
                  children: [
                    const TPromoSlider(),

                    const SizedBox(height: TSizes.spaceBtwSections),

                    // HEADING
                    TSectionHeading(title: "Popular Products", onPressed: () => Get.to(() => const AllProductsScreen())),

                    const SizedBox(height: TSizes.spaceBtwItems),

                    // PRODUCTS
                    Obx(() {
                      if (controller.isLoading.value) return const TVertialProductShimmer();

                      if (controller.featuredProducts.isEmpty) return Center(child: Text('No Data Found!', style: Theme.of(context).textTheme.bodyMedium));

                      return TGridLayout(
                        itemCount: controller.featuredProducts.length,
                        itemBuilder: (_, index) => TProductCardVertical(product: controller.featuredProducts[index]),
                      );
                    })
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
