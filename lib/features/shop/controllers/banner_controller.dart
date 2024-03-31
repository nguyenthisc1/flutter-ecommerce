import 'package:ecommerce/data/repositories/banners/banner_repository.dart';
import 'package:ecommerce/features/shop/models/banner_model.dart';
import 'package:ecommerce/utils/popups/loaders.dart';
import 'package:get/get.dart';

class BannerController extends GetxController {
  static BannerController get instance => Get.find();

  // VARIABLES
  final carousalCurrentIndex = 0.obs;
  final isLoading = false.obs;
  final _bannerRepository = Get.put(BannerRepository());
  final RxList<BannerModel> banners = <BannerModel>[].obs;

  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }

  // UPDATE PAGE NAVIGATIONAL DOTS
  void updatePageIndicator(index) {
    carousalCurrentIndex.value = index;
  }

  // FETCH Banners
  Future<void> fetchBanners() async {
    try {
      isLoading.value = true;

      // FETCH BANNERS
      final bannersRepo = await _bannerRepository.fetchBanners();

      // UPDATE THE CATEGORIES LIST
      banners.assignAll(bannersRepo);
    } catch (error) {
      TLoaders.errorSnackBar(title: 'Fetching Banners failed!', message: error.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
