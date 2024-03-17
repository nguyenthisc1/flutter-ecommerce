import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/features/shop/screens/order/widgets/orders_list.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppbar(
          title: Text('My Orders',
              style: Theme.of(context).textTheme.headlineSmall),
          showBackArrow: true),
      body: const Padding(
        padding: EdgeInsets.only(left: TSizes.defaultSpace, right: TSizes.defaultSpace, bottom: TSizes.defaultSpace),
        child: TOrdersListItems(),
      ),
    );
  }
}
