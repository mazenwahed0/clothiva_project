import 'package:get/get.dart';

import '../../../data/repositories/banners/banner_repository.dart';
import '../../../utils/constants/text_strings.dart';
import '../../../utils/popups/loaders.dart';
import '../models/banner_model.dart';

class BannerController extends GetxController {
  static BannerController get instance => Get.find();

  /// Variables
  final carouselCurrentindex = 0.obs;
  final isLoading = false.obs;
  final _bannerRepository = Get.put(BannerRepository());
  // List of Banners to fetch and keep the data to avoid the reads from the Firestore Database
  final RxList<BannerModel> banners = <BannerModel>[].obs;

  /// Update Page Navigational Dots
  void updatePageIndicator(index) {
    carouselCurrentindex.value = index;
  }

  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }

  /// Fetch Banners from Firebase
  Future<void> fetchBanners() async {
    try {
      // Start Loading while loading categories
      isLoading.value = true;

      // Fetch Banners from data source (Firestore, API, etc.)
      final banners = await _bannerRepository.fetchActiveBanners();

      // Update the categories list
      this.banners.assignAll(banners);

      // // Filter featured categories
      // featuredCategories.assignAll(allCategories
      //     .where((category) => category.isFeatured && category.parentId.isEmpty)
      //     .take(4)
      //     .toList());
    } catch (e) {
      Loaders.errorSnackBar(title: CTexts.ohSnap, message: e.toString());
    } finally {
      // Remove Loader
      isLoading.value = false;
    }
  }
}
