import 'dart:async';

import 'package:clothiva_project/data/repositories/product/product_repository.dart';
import 'package:clothiva_project/features/shop/models/product_model.dart';
import 'package:clothiva_project/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CSearchController extends GetxController {
  static CSearchController get instance => Get.find();

  final TextEditingController searchBarController = TextEditingController();
  final ProductRepository _productRepository = ProductRepository.instance;

  final RxBool isSearching = false.obs;
  final RxList<ProductModel> searchResults = <ProductModel>[].obs;
  final RxBool isLoading = false.obs;

  Timer? _debounce;

  @override
  void onInit() {
    // Listen to changes in the text controller
    searchBarController.addListener(_onSearchChanged);
    super.onInit();
  }

  // debounced listener function
  void _onSearchChanged() {
    // If a timer is already active, cancel it
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    // Start a new timer. This code will only run 500ms *after* the user stops typing
    _debounce = Timer(const Duration(milliseconds: 500), () {
      final query = searchBarController.text.trim();
      if (query.isEmpty) {
        isSearching.value = false;
        searchResults.clear();
      } else {
        isSearching.value = true;
        fetchSearchResults(query.toLowerCase());
      }
    });
  }

  Future<void> fetchSearchResults(String query) async {
    try {
      isLoading.value = true;

      // Split the query to use arrayContainsAny
      List<String> searchTerms = query
          .split(' ')
          .where((s) => s.isNotEmpty)
          .toList();

      // Pass the list of terms to the repository
      final products = await _productRepository.searchProductsByTitle(
        searchTerms,
      );
      searchResults.assignAll(products);
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void clearSearch() {
    _debounce?.cancel(); // <-- Cancel any pending timer
    searchBarController.clear();
    // No need to set isSearching or clear searchResults here,
    // as searchBarController.clear() will trigger _onSearchChanged.
  }

  @override
  void onClose() {
    _debounce?.cancel(); // <-- Always cancel timers
    searchBarController.removeListener(
      _onSearchChanged,
    ); // <-- Clean up listener
    searchBarController.dispose();
    super.onClose();
  }
}
