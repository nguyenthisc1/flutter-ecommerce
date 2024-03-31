import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TUploadActionItem extends StatelessWidget {
  const TUploadActionItem({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  final String title;
  final IconData? icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.md),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: TColors.primary,
              size: 24,
            ),
            const SizedBox(width: TSizes.md),
            Expanded(flex: 2,child: Text(title, style: Theme.of(context).textTheme.titleLarge)),
            const Expanded(
              flex: 1,
              child: Icon(
                Iconsax.document_upload,
                color: TColors.primary,
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
