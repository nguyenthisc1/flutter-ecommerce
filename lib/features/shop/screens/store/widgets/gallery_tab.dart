import 'package:ecommerce/common/widgets/brands/brand_show_case.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/features/shop/models/category_model.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TGalleryTab extends StatelessWidget {
  const TGalleryTab({
    super.key,
    required this.category,
  });

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(children: [
            // BRANDS
            const TBrandShowcase(images: [TImages.productImage1, TImages.productImage10, TImages.productImage11]),

            const TBrandShowcase(images: [TImages.productImage1, TImages.productImage10, TImages.productImage11]),

            // PRODUCTS
            TSectionHeading(
              title: "You might like",
              onPressed: () {},
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            // TGridLayout(itemCount: 4, itemBuilder: (_, index) => const TProductCardVertical()),
            const SizedBox(height: TSizes.spaceBtwSections),
          ]),
        )
      ],
    );
  }
}
