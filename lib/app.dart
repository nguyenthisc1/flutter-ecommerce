import 'package:ecommerce/features/shop/screens/product_reviews/product_reviews.dart';
import 'package:ecommerce/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      // home: const OnboardingScreen(),
      home: const ProductReviewsScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
