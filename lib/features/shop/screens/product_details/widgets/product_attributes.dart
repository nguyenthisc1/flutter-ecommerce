import 'package:ecommerce/common/widgets/chips/choice_chip.dart';
import 'package:ecommerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecommerce/common/widgets/texts/product_price_text.dart';
import 'package:ecommerce/common/widgets/texts/product_title_text.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TProductAttributes extends StatelessWidget {
  const TProductAttributes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        // SELECT ATTRIBUTES PRICING & DESCRIPTION
        TRoundedContainer(
          backgroundColor: dark ? TColors.darkGrey : TColors.grey,
          padding: const EdgeInsets.all(TSizes.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const TSectionHeading(
                      title: 'Variation', showActionButton: false),
                  const SizedBox(width: TSizes.spaceBtwItems),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // PRICE
                      Row(
                        children: [
                          const TProductTitleText(
                              title: 'Price : ', smallSize: true),
                          const SizedBox(width: TSizes.spaceBtwItems),
                          Row(
                            children: [
                              Text('\$25',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .apply(
                                          decoration:
                                              TextDecoration.lineThrough)),
                              const SizedBox(width: TSizes.spaceBtwItems),

                              // SALE PRICE
                              const TProductPriceText(price: '20')
                            ],
                          )
                        ],
                      ),

                      // STOCK
                      Row(
                        children: [
                          const TProductTitleText(
                              title: 'Stock: ', smallSize: true),
                          Row(
                            children: [
                              Text('In Stock',
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                              const SizedBox(width: TSizes.spaceBtwItems),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const TProductTitleText(
                title: 'This is the Description of the product',
                smallSize: true,
                maxLines: 4,
              )
            ],
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),

        // ATTRIBUTES
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TSectionHeading(title: 'Colors', showActionButton: false),
            SizedBox(height: TSizes.spaceBtwItems / 2),
            Wrap(
              spacing: 8,
              children: [
                TChoiceChip(text: 'Green', selected: true),
                TChoiceChip(text: 'Blue', selected: false),
                TChoiceChip(text: 'Yellow', selected: false),
              ],
            )
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems),

        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TSectionHeading(
              title: 'Size',
              showActionButton: false,
            ),
            SizedBox(height: TSizes.spaceBtwItems / 2),
            Wrap(
              spacing: 8,
              children: [
                TChoiceChip(text: 'EU 34', selected: true),
                TChoiceChip(text: 'EU 36', selected: false),
                TChoiceChip(text: 'EU 38', selected: false),
              ],
            )
          ],
        ),
      ],
    );
  }
}
