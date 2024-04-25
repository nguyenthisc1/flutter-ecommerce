import 'package:ecommerce/common/widgets/layout/grid_layout.dart';
import 'package:ecommerce/common/widgets/shimmers/shimmer_effect.dart';
import 'package:flutter/widgets.dart';

class TBrandsShimmer extends StatelessWidget {
  const TBrandsShimmer({Key? key, this.itemCount = 4}) : super(key: key);

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return TGridLayout(mainAxisExtent: 80, itemCount: itemCount, itemBuilder: (_, __) => const TShimmerEffect(width: 300, height: 80));
  }
}
