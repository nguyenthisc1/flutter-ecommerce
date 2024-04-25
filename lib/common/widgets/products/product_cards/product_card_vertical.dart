import 'package:ecommerce/common/styles/shadow_styles.dart';
import 'package:ecommerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecommerce/common/widgets/icon/circular_icon.dart';
import 'package:ecommerce/common/widgets/image/rounded_image.dart';
import 'package:ecommerce/common/widgets/texts/brand_title_with_verified_icon.dart';
import 'package:ecommerce/common/widgets/texts/product_price_text.dart';
import 'package:ecommerce/common/widgets/texts/product_title_text.dart';
import 'package:ecommerce/features/shop/controllers/product/product_controller.dart';
import 'package:ecommerce/features/shop/models/product_model.dart';
import 'package:ecommerce/features/shop/screens/product_details/product_detail.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/enums.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TProductCardVertical extends StatelessWidget {
  const TProductCardVertical({Key? key, required this.product}) : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePercentage = controller.calculateSalePercentage(product.price, product.salePrice);
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailScreen(product: product)),
      child: Container(
        width: 180,
        // padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(boxShadow: [TShadowStyles.verticalProductShadow], borderRadius: BorderRadius.circular(TSizes.productImageRadius), color: dark ? TColors.darkGrey : TColors.white),
        child: Column(children: [
          TRoundedContainer(
            width: double.infinity,
            height: 180,
            backgroundColor: dark ? TColors.dark : TColors.light,
            child: Stack(
              children: [
                // THUMBNAIL IMAGE
                Center(child: TRoundedImage(imageUrl: product.thumbnail, applyImageRadius: true, isNetworkImage: true)),

                // SALE TAG
                if (salePercentage != null)
                  Positioned(
                    top: 12,
                    child: TRoundedContainer(
                        radius: TSizes.sm,
                        backgroundColor: TColors.secondary.withOpacity(0.8),
                        padding: const EdgeInsets.symmetric(horizontal: TSizes.sm, vertical: TSizes.xs),
                        child: Text('$salePercentage%', style: Theme.of(context).textTheme.labelLarge!.apply(color: TColors.black))),
                  ),

                // FAVORITE BUTTON
                const Positioned(top: 6, right: 6, child: TCircularIcon(icon: Iconsax.heart5, color: Colors.red)),
              ],
            ),
          ),

          const SizedBox(height: TSizes.spaceBtwItems / 2),

          // DETAIL
          Padding(
            padding: const EdgeInsets.only(left: TSizes.sm),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TProductTitleText(
                    title: product.title,
                    smallSize: true,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems / 2),
                  TBrandTitleWithVerifiedIcon(title: product.brand!.name)
                ],
              ),
            ),
          ),

          const Spacer(),

          // TEXT
          Padding(
            padding: const EdgeInsets.only(left: TSizes.sm),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // PRICE
                Flexible(
                    child: Column(children: [
                  if (product.productType == ProductType.single.toString() && product.salePrice! > 0)
                    Padding(
                      padding: const EdgeInsets.only(left: TSizes.sm),
                      child: Text(product.price.toString(), style: Theme.of(context).textTheme.labelMedium!.apply(decoration: TextDecoration.lineThrough)),
                    ),
                  TProductPriceText(price: controller.getProductPrice(product)),
                ])),

                // ADD TO CART BUTTON
                Container(
                  decoration:
                      const BoxDecoration(color: TColors.dark, borderRadius: BorderRadius.only(topLeft: Radius.circular(TSizes.cardRadiusMd), bottomRight: Radius.circular(TSizes.productImageRadius))),
                  child: const SizedBox(
                    width: TSizes.iconLg * 1.2,
                    height: TSizes.iconLg * 1.2,
                    child: Center(
                      child: Icon(
                        Iconsax.add,
                        color: TColors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
