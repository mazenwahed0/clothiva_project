import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import '../../../../data/repositories/invitation/invitation_repository.dart';
import '../../../../data/repositories/product/product_repository.dart';
import '../../../../data/repositories/wishlist/wishlist_repository.dart';
import '../../../../utils/local_storage/storage_utility.dart';
import '../../../../utils/popups/loaders.dart';
import '../../models/product_model.dart';
import '../../models/wishlist_model.dart';

class FavouritesController extends GetxController {
  static FavouritesController get instance => Get.find();

  final favourites = <String, bool>{}.obs;
  final _wishlistRepo = WishlistRepository.instance;
  final _inviteRepo = InvitationRepository.instance;
  final _productsRepo = ProductRepository.instance;

  final RxBool isSharedMode = false.obs;
  final RxString sharedOwnerId = ''.obs;

  /// Stream subscription to manage the Firestore listener
  StreamSubscription<WishlistModel?>? _wishlistSubscription;
  final RxList<ProductModel> favouriteProductsList = <ProductModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    ever(isSharedMode, (_) => refreshMode());
    ever(favourites, (_) => _fetchFavouriteProducts());
    _initialize();
  }

  /// Helper to set initial state before listeners are active
  Future<void> _initialize() async {
    await initFavourites();
    refreshMode();
  }

  /// (This method is largely the same, just to set the initial isSharedMode)
  Future<void> initFavourites() async {
    try {
      final invites = await _inviteRepo.fetchCollaborators().first;
      final invite = invites.firstWhereOrNull(
        (i) => i.recipientId == _wishlistRepo.currentUser?.uid,
      );

      // 1. Check if user is a recipient AND sharing is disabled
      if (invite != null && !invite.shareEnabled) {
        isSharedMode.value = false;
        return;
      }

      // 2. Check if user has a shared wishlist (as owner or recipient)
      final shared = await _wishlistRepo.getUserWishlist();
      if (shared != null && shared.isShared) {
        isSharedMode.value = true;
        return;
      }

      // 3. Fallback to local storage
      isSharedMode.value = false;
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oops!', message: e.toString());
      isSharedMode.value = false; // Default to local on error
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
                "The owner disabled sharing. You can't modify the shared wishlist.",
          );
          return;
        }

        await _wishlistRepo.toggleProduct(productId);

        final isNowFavourite = isFavourite(productId);
        Loaders.customToast(
          message: isNowFavourite
              ? 'Product added to shared wishlist.'
              : 'Product removed from shared wishlist.',
        );
      } else {
        // Local Mode
        if (!favourites.containsKey(productId)) {
          favourites[productId] = true;
          saveFavouritesToStorage();
          Loaders.customToast(message: 'Product added to wishlist.');
        } else {
          favourites.remove(productId);
          saveFavouritesToStorage();
          favourites.refresh(); // Need refresh here for local
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

  /// Loads data based on the current 'isSharedMode.value'
  void refreshMode() {
    // Cancel any existing stream listener
    _wishlistSubscription?.cancel();
    favourites.clear();

    try {
      if (isSharedMode.value) {
        // SHARED MODE
        // Pass the specific owner ID to the repository
        String? targetId = sharedOwnerId.value.isNotEmpty
            ? sharedOwnerId.value
            : null;

        _wishlistSubscription = _wishlistRepo
            .getWishlistStream(targetOwnerId: targetId)
            .listen((wishlist) {
              final productIds = wishlist?.productIds ?? [];
              final newFavs = <String, bool>{};
              for (final id in productIds) {
                newFavs[id] = true;
              }
              favourites.assignAll(newFavs);
            });
      } else {
        // LOCAL MODE
        _loadLocalWishlist();
        // Manually trigger product fetch for local mode
        _fetchFavouriteProducts();
      }
    } catch (e) {
      Loaders.errorSnackBar(
        title: 'Error refreshing wishlist',
        message: e.toString(),
      );
    }
  }

  /// Fetches the full ProductModel details based on the current list of IDs
  Future<void> _fetchFavouriteProducts() async {
    try {
      isLoading.value = true;
      final productIds = favourites.keys.toList();

      if (productIds.isEmpty) {
        favouriteProductsList.clear();
      } else {
        final products = await _productsRepo.getFavouriteProducts(productIds);
        favouriteProductsList.assignAll(products);
      }
    } catch (e) {
      Loaders.errorSnackBar(
        title: 'Error loading products',
        message: e.toString(),
      );
    } finally {
      isLoading.value = false;
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

  @override
  void onClose() {
    _wishlistSubscription?.cancel();
    super.onClose();
  }
}
