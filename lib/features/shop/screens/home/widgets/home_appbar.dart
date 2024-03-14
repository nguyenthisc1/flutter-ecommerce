import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:ecommerce/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';

class THomeAppbar extends StatelessWidget {
  const THomeAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TAppbar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TTexts.homeAppbarTitle,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .apply(color: Colors.grey),
          ),
          Text(
            TTexts.homeAppbarSubTitle,
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .apply(color: Colors.white),
          )
        ],
      ),
      actions: [
        TCartCounterIcon(
          onPressed: () {},
        )
      ],
    );
  }
}
