import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/common/shimmers/shimmer_effect.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TCircularImage extends StatelessWidget {
  const TCircularImage({
    super.key,
    this.width = 56,
    this.height = 56,
    this.padding = TSizes.sm,
    this.fit = BoxFit.cover,
    required this.image,
    this.isNetworkImage = false,
    this.backgroundColor,
    this.overlayColor,
  });

  final double width, height, padding;
  final BoxFit fit;
  final String image;
  final bool isNetworkImage;
  final Color? backgroundColor, overlayColor;

  @override
    Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Container(
      width: width,
      height: height,
      clipBehavior: Clip.hardEdge,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: dark ? TColors.black : TColors.white),
      child: Center(
        child: isNetworkImage
            ? CachedNetworkImage(
                imageUrl: image,
                width: width + 10,
                height: height + 10,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    TShimmerEffect(width: width, height: height, radius: 100),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              )
            : Image(
                fit: fit,
                width: width + 10,
                height: height + 10,
                image: AssetImage(image),
                color: overlayColor,
              ),
      ),
    );
  }
}
