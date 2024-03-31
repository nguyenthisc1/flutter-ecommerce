import 'package:ecommerce/data/repositories/categories/category_repository.dart';
import 'package:ecommerce/utils/data/dummy_data.dart';
import 'package:ecommerce/utils/popups/loaders.dart';
import 'package:get/get.dart';

class UploadDataController extends GetxController {
  static UploadDataController get instance => Get.find();

  final categoryRepository = CategoryRepository.instance;

  Future<void> uploadCategoriesData() async {
    try {
      await categoryRepository.uploadDummyData(TDummyData.categories);
    } catch (error) {
      TLoaders.errorSnackBar(title: 'Upload failed!', message: error.toString());
    }
  }
}
