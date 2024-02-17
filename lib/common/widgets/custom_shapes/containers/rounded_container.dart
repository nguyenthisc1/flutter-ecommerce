import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TRoundedContainer extends StatelessWidget {
  const TRoundedContainer({
    Key? key,
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.backgroundColor = TColors.white,
    this.borderColor = TColors.primary,
    this.radius = TSizes.cardRadiusLg,
    this.showBorder = false,
    this.child,
  }) : super(key: key);

  final double? width, height;
  final EdgeInsetsGeometry? margin, padding;
  final Color backgroundColor, borderColor;
  final double radius;
  final Widget? child;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
        border: showBorder ? Border.all(color: borderColor) : null,
      ),
      child: child,
    );
  }
}
