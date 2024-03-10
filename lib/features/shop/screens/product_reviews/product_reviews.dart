import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/device/device_utility.dart';
import 'package:flutter/material.dart';

class ProductReviewsScreen extends StatelessWidget {
  const ProductReviewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppbar(
        title: Text('Reviews & Ratings'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                  'Ratings and reviews are verified and are from people who use the same type of device that of use.'),
              const SizedBox(height: TSizes.spaceBtwItems),

              // OVERALL PRODUCT RATINGS
              Row(
                children: [
                  Expanded(
                      flex: 3,
                      child: Text('4.8',
                          style: Theme.of(context).textTheme.displayLarge)),
                  Expanded(
                    flex: 7,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text('5',
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                            ),
                            Expanded(
                              flex: 11,
                              child: SizedBox(
                                width:
                                    TDeviceUtils.getScreenWidth(context) * 0.8,
                                child: LinearProgressIndicator(
                                    value: 0.5,
                                    minHeight: 11,
                                    backgroundColor: TColors.grey,
                                    valueColor: const AlwaysStoppedAnimation(
                                        TColors.primary),
                                    borderRadius: BorderRadius.circular(7)),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
