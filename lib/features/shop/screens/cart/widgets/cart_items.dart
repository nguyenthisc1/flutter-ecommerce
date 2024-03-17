import 'package:ecommerce/common/widgets/products/cart/add_remove_button.dart';
import 'package:ecommerce/common/widgets/products/cart/cart_item.dart';
import 'package:ecommerce/common/widgets/texts/product_price_text.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TCartItems extends StatelessWidget {
  const TCartItems({
    super.key,
    this.showAddRemoveButtons = true,
  });

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        itemCount: 4,
        separatorBuilder: (_, __) => const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
        itemBuilder: (_, index) => Column(
              children: [
                const TCartItem(),
                if (showAddRemoveButtons)
                  const SizedBox(height: TSizes.spaceBtwItems),

                // ADD REMOVE BUTTONS WITH TOTAL PRICE
                if (showAddRemoveButtons)
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 70),
                          TProductQuantityWithAddRemoveButton(),
                        ],
                      ),
                      TProductPriceText(price: '255')
                    ],
                  )
              ],
            ));
  }
}
