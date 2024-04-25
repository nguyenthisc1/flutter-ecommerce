import 'package:ecommerce/data/repositories/brands/brand_repository.dart';
import 'package:ecommerce/data/repositories/products/product_repository.dart';
import 'package:ecommerce/features/shop/models/brand_model.dart';
import 'package:ecommerce/features/shop/models/product_model.dart';
import 'package:ecommerce/utils/popups/loaders.dart';
import 'package:get/get.dart';

class BrandController extends GetxController {
  static BrandController get instance => Get.find();

  // VARIABLES
  RxBool isLoading = false.obs;
  final RxList<BrandModel> featuredBrands = <BrandModel>[].obs;
  final RxList<BrandModel> allBrands = <BrandModel>[].obs;
  final _brandRepository = Get.put(BrandRepository());


  // LOAD BRANDS
  Future<void> getFeaturedBrand() async {
    try {
      isLoading.value = true;

      final brands = await _brandRepository.getAllBrands();

      allBrands.assignAll(brands);
      featuredBrands.assignAll(allBrands.where((brand) => brand.isFeatured ?? false).take(4));
    } catch (error) {
      TLoaders.errorSnackBar(title: 'Fetching Brands failed!', message: error.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // GET BRANDS FOR CATEGORY

  // GET BRANDS SPECIFIC PRODUCTS FROM YOUR DATA SOURCE
  Future<List<ProductModel>> getBrandProducts(String brandId) async {
    try {
      final products = await ProductRepository.instance.getProductsForBrand(brandId: brandId);

      return products;
    } catch (error) {
      TLoaders.errorSnackBar(title: 'Fetch Brand Products Field!', message: error.toString());
      return [];
    }
  }
}
