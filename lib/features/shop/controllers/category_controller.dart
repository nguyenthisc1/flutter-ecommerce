import 'package:ecommerce/data/repositories/categories/category_repository.dart';
import 'package:ecommerce/features/shop/models/category_model.dart';
import 'package:ecommerce/utils/popups/loaders.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  // VARIABLES
  final isLoading = false.obs;
  final _categoryRepository = Get.put(CategoryRepository());
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  // FETCH CATEGORIES
  Future<void> fetchCategories() async {
    try {
      isLoading.value = true;

      // FETCH CATEGORIES
      final categories = await _categoryRepository.fetchCategories();

      // UPDATE THE CATEGORIES LIST
      allCategories.assignAll(categories);

      // FILTER FEATURED CATEGORIES
      featuredCategories.assignAll(allCategories.where((category) => category.isFeatured && category.parentId.isEmpty).take(8).toList());
    } catch (error) {
      TLoaders.errorSnackBar(title: 'Fetching Categories failed!', message: error.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // LOAD CATEGORY DATA

  // LOAD SELECTED CATEGORY DATA

  // GET CATEGORY OR SUB-CATEGORY PRODUCTS
}
