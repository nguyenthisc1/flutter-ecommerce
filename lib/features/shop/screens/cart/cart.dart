import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/products/cart/add_remove_button.dart';
import 'package:ecommerce/common/widgets/products/cart/cart_item.dart';
import 'package:ecommerce/common/widgets/texts/product_price_text.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: TAppbar(
          title:
              Text('Cart', style: Theme.of(context).textTheme.headlineSmall)),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
            onPressed: () {}, child: const Text('Checkout \$256')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ListView.separated(
            shrinkWrap: true,
            itemCount: 4,
            separatorBuilder: (_, __) => const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
            itemBuilder: (_, idx) => const Column(
                  children: [
                    TCartItem(),
                    SizedBox(height: TSizes.spaceBtwItems),

                    // ADD REMOVE BUTTONS
                    Row(
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
                )),
      ),
    );
  }
}
