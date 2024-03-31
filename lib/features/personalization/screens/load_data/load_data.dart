import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/features/personalization/screens/load_data/widgets/upload_action_item.dart';
import 'package:ecommerce/features/shop/controllers/upload_data_controller.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class LoadDataScreen extends StatelessWidget {
  const LoadDataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UploadDataController());
    return Scaffold(
      appBar: const TAppbar(
        showBackArrow: true,
        title: Text('Upload Data'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              Column(
                children: [
                  const TSectionHeading(title: 'Main record', showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  TUploadActionItem(
                    title: 'Upload Categories',
                    icon: Iconsax.category,
                    onTap: () => controller.uploadCategoriesData(),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems * 2),
                  const TUploadActionItem(
                    title: 'Upload Brands',
                    icon: Iconsax.building,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems * 2),
                  const TUploadActionItem(
                    title: 'Upload Products',
                    icon: Iconsax.chart4,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems * 2),
                  const TUploadActionItem(
                    title: 'Upload Banners',
                    icon: Iconsax.image,
                  ),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              const Column(
                children: [
                  TSectionHeading(title: 'Relationships', showActionButton: false),
                  SizedBox(height: TSizes.spaceBtwItems),
                  TUploadActionItem(
                    title: 'Upload Brand & Categories Relation Data',
                    icon: Iconsax.data4,
                  ),
                  SizedBox(height: TSizes.spaceBtwItems * 2),
                  TUploadActionItem(
                    title: 'Upload Brand & Categories Relation Data',
                    icon: Iconsax.data4,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
