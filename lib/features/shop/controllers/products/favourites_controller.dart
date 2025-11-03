import 'dart:convert';
import 'package:get/get.dart';
import '../../../../data/repositories/invitation/invitation_repository.dart';
import '../../../../data/repositories/product/product_repository.dart';
import '../../../../data/repositories/wishlist/wishlist_repository.dart';
import '../../../../utils/local_storage/storage_utility.dart';
import '../../../../utils/popups/loaders.dart';
import '../../models/product_model.dart';

class FavouritesController extends GetxController {
  static FavouritesController get instance => Get.find();

  final favourites = <String, bool>{}.obs;
  final _wishlistRepo = WishlistRepository.instance;
  final _inviteRepo = InvitationRepository.instance;

  final RxBool isSharedMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    initFavourites();
  }

  /// Called on initial app load to set the default state
  Future<void> initFavourites() async {
    try {
      final invites = await _inviteRepo.fetchCollaborators().first;
      final invite = invites.firstWhereOrNull(
        (i) => i.recipientId == _wishlistRepo.currentUser?.uid,
      );

      // 1. Check if user is a recipient AND sharing is disabled
      if (invite != null && !invite.shareEnabled) {
        isSharedMode.value = false;
        _loadLocalWishlist();
        return;
      }

      // 2. Check if user has a shared wishlist (as owner or recipient)
      final shared = await _wishlistRepo.getUserWishlist();
      if (shared != null && shared.isShared) {
        isSharedMode.value = true;
        favourites.clear();
        for (final id in shared.productIds) {
          favourites[id] = true;
        }
        favourites.refresh();
        return;
      }

      // 3. Fallback to local storage
      isSharedMode.value = false;
      _loadLocalWishlist();
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  bool isFavourite(String productId) => favourites[productId] ?? false;

  /// Toggle product — Firestore if shared, local if not.
  Future<void> toggleFavouriteProduct(String productId) async {
    try {
      if (isSharedMode.value) {
        // Check if sharing is still enabled (recipient check)
        final invites = await _inviteRepo.fetchCollaborators().first;
        final invite = invites.firstWhereOrNull(
          (i) => i.recipientId == _wishlistRepo.currentUser?.uid,
        );

        if (invite != null && !invite.shareEnabled) {
          Loaders.warningSnackBar(
            title: "Sharing Disabled",
            message:
                "The owner disabled sharing. You can’t modify the shared wishlist.",
          );
          return;
        }

        // --- All checks passed, update Firestore ---
        await _wishlistRepo.toggleProduct(productId);
        // Refresh local cache from Firestore
        final w = await _wishlistRepo.getUserWishlist();
        favourites.clear();
        if (w != null) {
          for (final id in w.productIds) favourites[id] = true;
        }
        favourites.refresh();
        Loaders.customToast(
          message: w != null && w.productIds.contains(productId)
              ? 'Product added to shared wishlist.'
              : 'Product removed from shared wishlist.',
        );
      } else {
        // --- Local Mode ---
        if (!favourites.containsKey(productId)) {
          favourites[productId] = true;
          saveFavouritesToStorage();
          Loaders.customToast(message: 'Product added to wishlist.');
        } else {
          favourites.remove(productId);
          saveFavouritesToStorage();
          favourites.refresh();
          Loaders.customToast(message: 'Product removed from wishlist.');
        }
      }
    } catch (e) {
      Loaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }

  void saveFavouritesToStorage() {
    final encoded = json.encode(favourites);
    CLocalStorage.instance().saveData('favourites', encoded);
  }

  Future<List<ProductModel>> favouriteProducts() async {
    try {
      final List<String> productIds;
      if (isSharedMode.value) {
        final w = await _wishlistRepo.getUserWishlist();
        productIds = w?.productIds ?? [];
      } else {
        productIds = favourites.keys.toList();
      }

      if (productIds.isEmpty) return [];
      return await ProductRepository.instance.getFavouriteProducts(productIds);
    } catch (e) {
      Loaders.errorSnackBar(title: 'Error', message: e.toString());
      return [];
    }
  }

  /// Simplified: Loads data based on the current 'isSharedMode.value'
  Future<void> refreshMode() async {
    try {
      if (isSharedMode.value) {
        // Load SHARED
        final shared = await _wishlistRepo.getUserWishlist();
        favourites.clear();
        if (shared != null) {
          favourites.addEntries(
            shared.productIds.map((id) => MapEntry(id, true)),
          );
        }
      } else {
        // Load LOCAL
        _loadLocalWishlist();
      }
      favourites.refresh();
    } catch (e) {
      Loaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }

  void _loadLocalWishlist() {
    favourites.clear();
    final json = CLocalStorage.instance().readData('favourites');
    if (json != null) {
      final stored = jsonDecode(json) as Map<String, dynamic>;
      favourites.assignAll(stored.map((k, v) => MapEntry(k, v as bool)));
    }
  }
}
