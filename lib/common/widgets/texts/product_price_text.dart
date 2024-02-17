import 'package:flutter/material.dart';

class TProductPriceText extends StatelessWidget {
  const TProductPriceText(
      {Key? key,
      required this.price,
      this.currencySign = '\$',
      this.maxLines = 1,
      this.isLarge = false,
      this.lineThrough = false})
      : super(key: key);

  final String currencySign, price;
  final int maxLines;
  final bool isLarge, lineThrough;

  @override
  Widget build(BuildContext context) {
    return Text(
      currencySign + price,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: isLarge
          ? Theme.of(context).textTheme.headlineMedium!.apply(
              decoration: lineThrough ? TextDecoration.lineThrough : null)
          : Theme.of(context).textTheme.titleLarge!.apply(
              decoration: lineThrough ? TextDecoration.lineThrough : null),
    );
  }
}
