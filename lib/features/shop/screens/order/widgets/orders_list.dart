import 'package:ecommerce/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TOrdersListItems extends StatelessWidget {
  const TOrdersListItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 20,
      separatorBuilder: (_, index) =>
          const SizedBox(height: TSizes.spaceBtwItems),
      itemBuilder: (_, index) => TRoundedContainer(
        padding: const EdgeInsets.all(TSizes.md),
        showBorder: true,
        backgroundColor: dark ? TColors.dark : TColors.light,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          // ROW 1
          Row(
            children: [
              // 1 - ICON
              const Icon(Iconsax.ship),
              const SizedBox(width: TSizes.spaceBtwItems / 2),

              // 2 - STATUS & DATE
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Processcing',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .apply(color: TColors.primary, fontWeightDelta: 1)),
                    Text('07 Nov 2024',
                        style: Theme.of(context).textTheme.headlineSmall)
                  ],
                ),
              ),

              // 3 - ICON
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Iconsax.arrow_right_34, size: TSizes.iconSm))
            ],
          ),

          const SizedBox(height: TSizes.spaceBtwItems),

          // ROW 2
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    // 1 - ICON
                    const Icon(Iconsax.ship),
                    const SizedBox(width: TSizes.spaceBtwItems / 2),

                    // 2 - STATUS & DATE
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Order',
                              style: Theme.of(context).textTheme.labelMedium),
                          Text('[#34512]',
                              style: Theme.of(context).textTheme.titleMedium)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    // 1 - ICON
                    const Icon(Iconsax.ship),
                    const SizedBox(width: TSizes.spaceBtwItems / 2),

                    // 2 - STATUS & DATE
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Order',
                              style: Theme.of(context).textTheme.labelMedium),
                          Text('[#34512]',
                              style: Theme.of(context).textTheme.titleMedium)
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ]),
      ),
    );
  }
}
