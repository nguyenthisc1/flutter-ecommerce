import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TSearchHeading extends StatelessWidget {
  const TSearchHeading({
    super.key,
    this.textColor,
    this.showActionButton = true,
    required this.title,
    required this.buttonTitle,
    this.onPressed,
  });

  final Color? textColor;
  final bool showActionButton;
  final String title, buttonTitle;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: TSizes.defaultSpace),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .apply(color: textColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (showActionButton)
                TextButton(onPressed: onPressed, child: Text(buttonTitle))
            ],
          )
        ],
      ),
    );
  }
}
