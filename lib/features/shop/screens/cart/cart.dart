import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/image/rounded_image.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: ListView.separated(
              itemCount: 4,
              separatorBuilder: (_, __) => const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
              itemBuilder: (_, idx) => Column(
                    children: [
                      Row(
                        children: [
                          // IMAGE
                          TRoundedImage(
                            imageUrl: TImages.productImage1,
                            width: 60,
                            height: 60,
                            padding: const EdgeInsets.all(TSizes.sm),
                            backgroundColor:
                                dark ? TColors.darkGrey : TColors.light,
                          )
                        ],
                      )
                    ],
                  )),
        ),
      ),
    );
  }
}
