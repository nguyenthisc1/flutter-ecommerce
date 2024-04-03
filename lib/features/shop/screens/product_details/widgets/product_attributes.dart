import 'package:ecommerce/common/widgets/chips/choice_chip.dart';
import 'package:ecommerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecommerce/common/widgets/texts/product_price_text.dart';
import 'package:ecommerce/common/widgets/texts/product_title_text.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/features/shop/controllers/product/product_variation_controller.dart';
import 'package:ecommerce/features/shop/models/product_model.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TProductAttributes extends StatelessWidget {
  const TProductAttributes({Key? key, required this.product}) : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductVariationController());
    final dark = THelperFunctions.isDarkMode(context);
    return Obx(() => Column(
          children: [
            // SELECT ATTRIBUTES PRICING & DESCRIPTION
            if (controller.selectedVariation.value.id.isNotEmpty)
              TRoundedContainer(
                backgroundColor: dark ? TColors.darkGrey : TColors.grey,
                padding: const EdgeInsets.all(TSizes.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const TSectionHeading(title: 'Variation', showActionButton: false),
                        const SizedBox(width: TSizes.spaceBtwItems),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // PRICE
                            Row(
                              children: [
                                const TProductTitleText(title: 'Price : ', smallSize: true),
                                const SizedBox(width: TSizes.spaceBtwItems),
                                Row(
                                  children: [
                                    if (controller.selectedVariation.value.salePrice > 0)
                                      Text('\$${controller.getVariationPrice()}', style: Theme.of(context).textTheme.titleSmall!.apply(decoration: TextDecoration.lineThrough)),
                                    const SizedBox(width: TSizes.spaceBtwItems),

                                    // SALE PRICE
                                    TProductPriceText(price: controller.getVariationPrice())
                                  ],
                                )
                              ],
                            ),

                            // STOCK
                            Row(
                              children: [
                                const TProductTitleText(title: 'Stock: ', smallSize: true),
                                Row(
                                  children: [
                                    Text(controller.variationStockStatus.value, style: Theme.of(context).textTheme.titleMedium),
                                    const SizedBox(width: TSizes.spaceBtwItems),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    TProductTitleText(title: controller.selectedVariation.value.description ?? '', smallSize: true, maxLines: 4)
                  ],
                ),
              ),
            if (controller.selectedVariation.value.id.isNotEmpty) const SizedBox(height: TSizes.spaceBtwItems),

            // ATTRIBUTES
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: product.productAttributes!
                    .map((attribute) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TSectionHeading(title: attribute.name ?? '', showActionButton: false),
                            const SizedBox(height: TSizes.spaceBtwItems / 2),
                            Obx(() => Wrap(
                                  spacing: 8,
                                  children: attribute.values!.map((attributeValue) {
                                    final isSelected = controller.selectedAttributes[attribute.name] == attributeValue;
                                    final available = controller.getAttributeAvailabilityVariation(product.productVariation!, attribute.name!).contains(attributeValue);

                                    return TChoiceChip(
                                      text: attributeValue,
                                      selected: isSelected,
                                      onPressed: available
                                          ? (selected) {
                                              if (selected && available) {
                                                controller.onAttributeSelected(product, attribute.name ?? '', attributeValue);
                                              }
                                            }
                                          : null,
                                    );
                                  }).toList(),
                                )),
                            const SizedBox(height: TSizes.spaceBtwItems),
                          ],
                        ))
                    .toList())
          ],
        ));
  }
}
