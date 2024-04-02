import 'package:ecommerce/data/repositories/products/product_repository.dart';
import 'package:ecommerce/features/shop/models/product_model.dart';
import 'package:ecommerce/utils/constants/enums.dart';
import 'package:ecommerce/utils/popups/loaders.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  // VARIABLES
  final isLoading = false.obs;
  final productRepository = Get.put(ProductRepository());
  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;

  @override
  void onInit() {
    fetchFeaturedProducts();
    super.onInit();
  }

  // FETCH FEATURED PRODUCTS
  void fetchFeaturedProducts() async {
    try {
      // SHOW LOADING
      isLoading.value = true;

      // FETCH PRODUCTS
      final products = await productRepository.getFeaturedProducts();

      // ASSIGN PRODUCT
      featuredProducts.assignAll(products);
    } catch (error) {
      TLoaders.errorSnackBar(title: 'Fetch Product Failed!', message: error.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // GET THE PRODUCT PRICE OR PRICE RANGE FOR VARIATIONS
  String getProductPrice(ProductModel product) {
    double smallestPrice = double.infinity;
    double largePrice = 0.0;

    // IF NO VARIATIONS EXIST, RETURN THE SIMPLE PRICE OR SALE PRICE
    if (product.productType == ProductType.single.toString()) {
      return (product.salePrice! > 0 ? product.salePrice : product.price).toString();
    } else {
      // CALCULATE THE SMALLEST AND LARGEST PRICES AMONG VARIATIONS
      for (var variation in product.productVariation!) {
        // DETERMINE THE PRICE TO CONSIDER (SALE PRICE IF AVAILABLE, OTHER WISE REGULAR PRICE)
        double priceConsider = variation.salePrice > 0.0 ? variation.salePrice : variation.price;

        // UPDATE SMALLEST AND LARGEST PRICES
        if (priceConsider < smallestPrice) {
          smallestPrice = priceConsider;
        }

        if (priceConsider > largePrice) {
          largePrice = priceConsider;
        }
      }

      // IF SMALLEST AND LARGEST PRICES ARE THE SAME, RETURN A SINGLE PRICE
      if (smallestPrice.isEqual(largePrice)) {
        return largePrice.toString();
      } else {
        // OTHERWISE, RETURN A PRICE RANGE
        return '$smallestPrice - \$$largePrice';
      }
    }
  }

  // CALCULATE DISCOUNT PERCENTAGE
  String? calculateSalePercentage(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0) return null;
    if (originalPrice <= 0) return null;

    double percentage = ((originalPrice - salePrice) / originalPrice) * 100;
    return percentage.toStringAsFixed(0);
  }

  // CHECK PRODUCT STOCK STATUS
  String getProductStockStatus(int stock) {
    return stock > 0 ? 'In Stock' : 'Out of Stock';
  }
}
