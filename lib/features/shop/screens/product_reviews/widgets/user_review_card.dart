import 'package:ecommerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecommerce/common/widgets/products/ratings/rating_indicator.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CircleAvatar(
                    backgroundImage: AssetImage(TImages.userProfileImage1)),
                const SizedBox(width: TSizes.spaceBtwItems),
                Text('John Doe', style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
          ],
        ),

        const SizedBox(width: TSizes.spaceBtwItems),

// REVIEWS
        Row(
          children: [
            const TRatingBarIndicator(rating: 4),
            const SizedBox(width: TSizes.spaceBtwItems),
            Text('01 Nov 2023', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),

        const SizedBox(height: TSizes.spaceBtwItems),

        const ReadMoreText(
          'Lorem ipsum dolor sit, amet consectetur adipisicing elit. Laudantium quasi odit quod non eum optio repudiandae praesentium ratione perspiciatis rerum sunt explicabo aspernatur possimus maxime labore ipsa numquam, ducimus est.',
          trimLength: 2,
          trimExpandedText: 'show less',
          trimCollapsedText: 'show more',
          trimMode: TrimMode.Line,
          moreStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: TColors.primary),
          lessStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: TColors.primary),
        ),

        const SizedBox(height: TSizes.spaceBtwItems),

        // COMPANY REVIEW
        TRoundedContainer(
          backgroundColor: dark ? TColors.darkGrey : TColors.grey,
          child: Padding(
            padding: const EdgeInsets.all(TSizes.md),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("T's Store",
                      style: Theme.of(context).textTheme.titleMedium),
                  Text("01 Nov 2023",
                      style: Theme.of(context).textTheme.bodyMedium)
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              const ReadMoreText(
                'Lorem ipsum dolor sit, amet consectetur adipisicing elit. Laudantium quasi odit quod non eum optio repudiandae praesentium ratione perspiciatis rerum sunt explicabo aspernatur possimus maxime labore ipsa numquam, ducimus est.',
                trimLength: 2,
                trimExpandedText: 'show less',
                trimCollapsedText: 'show more',
                trimMode: TrimMode.Line,
                moreStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: TColors.primary),
                lessStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: TColors.primary),
              ),
            ]),
          ),
        ),

        const SizedBox(height: TSizes.spaceBtwSections),
      ],
    );
  }
}
