import 'package:ecommerce/common/widgets/shimmers/shimmer_effect.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TCategoryShimmer extends StatelessWidget {
  const TCategoryShimmer({Key? key, this.itemCount = 6}) : super(key: key);

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, __) => const SizedBox(width: TSizes.spaceBtwItems),
          separatorBuilder: (_, __) => const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // IMAGE
                  TShimmerEffect(width: 55, height: 55, radius: 55),
                  SizedBox(height: TSizes.spaceBtwItems / 2),

                  // TEXT
                  TShimmerEffect(width: 55, height: 8),
                ],
              ),
          itemCount: itemCount),
    );
  }
}
