import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../features/shop/models/product_model.dart';
import '../../../utils/constants/keys.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import 'package:dio/dio.dart' as dio;

import '../../../utils/helpers/helper_functions.dart';
import '../../services/storage/cloudinary_service.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  final _cloudinaryServices = Get.put(CloudinaryService());

  /// [Upload] - Function to upload list of products to Firebase
  Future<void> uploadProducts(List<ProductModel> products) async {
    try {
      for (ProductModel product in products) {
        final Map<String, String> uploadedImageMap =
            {}; // 'assets/products/productImage4' : 'https:cloudinary'

        // upload thumbnail to cloudinary
        File thumbnailFile = await CHelperFunctions.assetToFile(
          product.thumbnail,
        );
        dio.Response response = await _cloudinaryServices.uploadImage(
          thumbnailFile,
          CKeys.productsFolder,
          publicId: '${product.id}_thumbnail',
        );
        if (response.statusCode == 200) {
          String url = response.data['secure_url'];
          uploadedImageMap[product.thumbnail] = url;
          product.thumbnail = url;
        }

        // upload product images
        if (product.images != null && product.images!.isNotEmpty) {
          List<String> imageUrls = [];

          for (String image in product.images!) {
            // upload image to cloudinary
            File imageFile = await CHelperFunctions.assetToFile(image);
            dio.Response response = await _cloudinaryServices.uploadImage(
              imageFile,
              CKeys.productsFolder,
              publicId:
                  '${product.id}_${DateTime.now().millisecondsSinceEpoch}',
            );
            if (response.statusCode == 200) {
              imageUrls.add(response.data['secure_url']);
            }
          }

          // upload product variation images
          if (product.productVariations != null &&
              product.productVariations!.isNotEmpty) {
            for (int i = 0; i < product.images!.length; i++) {
              uploadedImageMap[product.images![i]] = imageUrls[i];
            }

            for (final variation in product.productVariations!) {
              final match = uploadedImageMap.entries.firstWhere(
                (entry) => entry.key == variation.image,
                orElse: () => const MapEntry('', ''),
              );
              if (match.key.isNotEmpty) {
                variation.image = match.value;
              }
            }
          }

          product.images!.clear();
          product.images!.assignAll(imageUrls);
        }

        // -- Upload product to Firestore
        await _db
            .collection(CKeys.productsCollection)
            .doc(product.id)
            .set(product.toJson());

        debugPrint('Product ${product.id} uploaded');
      }
    } on FirebaseException catch (e) {
      throw CFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw CFormatException();
    } on PlatformException catch (e) {
      throw CPlatformException(e.code).message;
    } catch (e) {
      rethrow;
    }
  }

  /// [Fetch] - Function to fetch list of products from Firebase
  Future<List<ProductModel>> fetchAllProducts() async {
    try {
      final query = await _db.collection(CKeys.productsCollection).get();

      if (query.docs.isNotEmpty) {
        List<ProductModel> products = query.docs
            .map((document) => ProductModel.fromSnapshot(document))
            .toList();
        return products;
      }

      return [];
    } on FirebaseException catch (e) {
      throw CFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw CFormatException();
    } on PlatformException catch (e) {
      throw CPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [Fetch] - Function to fetch single products from Firebase
  Future<ProductModel> fetchSingleProduct(String productId) async {
    try {
      final query = await _db
          .collection(CKeys.productsCollection)
          .doc(productId)
          .get();

      if (query.id.isNotEmpty) {
        ProductModel product = ProductModel.fromSnapshot(query);
        return product;
      }

      return ProductModel.empty();
    } on FirebaseException catch (e) {
      throw CFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw CFormatException();
    } on PlatformException catch (e) {
      throw CPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [Fetch] - Function to fetch list of products from Firebase
  Future<List<ProductModel>> fetchFeaturedProducts() async {
    try {
      final query = await _db
          .collection(CKeys.productsCollection)
          .where('isFeatured', isEqualTo: true)
          .limit(4)
          .get();

      if (query.docs.isNotEmpty) {
        List<ProductModel> products = query.docs
            .map((document) => ProductModel.fromSnapshot(document))
            .toList();
        return products;
      }

      return [];
    } on FirebaseException catch (e) {
      throw CFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw CFormatException();
    } on PlatformException catch (e) {
      throw CPlatformException(e.code).message;
    } catch (e) {
      debugPrint('Error while getting featured products:$e');
      throw 'Something went wrong. Please try again';
    }
  }

  /// [Fetch] - Function to fetch all list of products from Firebase
  Future<List<ProductModel>> fetchAllFeaturedProducts() async {
    try {
      final query = await _db
          .collection(CKeys.productsCollection)
          .where('isFeatured', isEqualTo: true)
          .get();

      if (query.docs.isNotEmpty) {
        List<ProductModel> products = query.docs
            .map((document) => ProductModel.fromSnapshot(document))
            .toList();
        return products;
      }

      return [];
    } on FirebaseException catch (e) {
      throw CFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw CFormatException();
    } on PlatformException catch (e) {
      throw CPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [Fetch] - Function to fetch all list of products from Firebase
  Future<List<ProductModel>> fetchProductsByQuery(Query query) async {
    try {
      final querySnapshot = await query.get();

      if (querySnapshot.docs.isNotEmpty) {
        List<ProductModel> products = querySnapshot.docs
            .map((document) => ProductModel.fromQuerySnapshot(document))
            .toList();
        return products;
      }

      return [];
    } on FirebaseException catch (e) {
      throw CFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw CFormatException();
    } on PlatformException catch (e) {
      throw CPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [Fetch] - Function to fetch all list of brand specific products
  Future<List<ProductModel>> getProductsForBrand({
    required String brandId,
    int limit = -1,
  }) async {
    try {
      final query = limit == -1
          ? await _db
                .collection(CKeys.productsCollection)
                .where('brand.id', isEqualTo: brandId)
                .get()
          : await _db
                .collection(CKeys.productsCollection)
                .where('brand.id', isEqualTo: brandId)
                .limit(limit)
                .get();

      if (query.docs.isNotEmpty) {
        List<ProductModel> products = query.docs
            .map((document) => ProductModel.fromSnapshot(document))
            .toList();
        return products;
      }

      return [];
    } on FirebaseException catch (e) {
      throw CFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw CFormatException();
    } on PlatformException catch (e) {
      throw CPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [Fetch] - Function to fetch all list of category specific products
  Future<List<ProductModel>> getProductsForCategory({
    required String categoryId,
    int limit = 4,
  }) async {
    try {
      final productCategoryQuery = limit == -1
          ? await _db
                .collection(CKeys.productCategoryCollection)
                .where('categoryId', isEqualTo: categoryId)
                .get()
          : await _db
                .collection(CKeys.productCategoryCollection)
                .where('categoryId', isEqualTo: categoryId)
                .limit(limit)
                .get();

      List<String> productIds = productCategoryQuery.docs
          .map((doc) => doc['productId'] as String)
          .toList();

      if (productIds.isEmpty) {
        return [];
      }

      final productQuery = await _db
          .collection(CKeys.productsCollection)
          .where(FieldPath.documentId, whereIn: productIds)
          .get();

      List<ProductModel> products = productQuery.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();

      return products;
    } on FirebaseException catch (e) {
      throw CFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw CFormatException();
    } on PlatformException catch (e) {
      throw CPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [Fetch] - Function to fetch list of favourite products from Firebase
  Future<List<ProductModel>> getFavouriteProducts(
    List<String> productsIds,
  ) async {
    try {
      if (productsIds.isEmpty) return [];
      final query = await _db
          .collection(CKeys.productsCollection)
          .where(FieldPath.documentId, whereIn: productsIds)
          .get();

      if (query.docs.isNotEmpty) {
        List<ProductModel> products = query.docs
            .map((document) => ProductModel.fromSnapshot(document))
            .toList();
        return products;
      }

      return [];
    } on FirebaseException catch (e) {
      throw CFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw CFormatException();
    } on PlatformException catch (e) {
      throw CPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Fetch all products that are on sale
  Future<List<ProductModel>> fetchAllSaleProducts() async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where('salePrice', isGreaterThan: 0)
          .get();

      final products = snapshot.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();
      return products;
    } on FirebaseException catch (e) {
      throw CFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw CPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [Search] - Function to search products by title (using keywords)
  Future<List<ProductModel>> searchProductsByTitle(
    List<String> searchTerms,
  ) async {
    try {
      if (searchTerms.isEmpty) return []; // <-- Check if the list is empty

      // Then, use 'array-contains-any'
      final snapshot = await _db
          .collection(CKeys.productsCollection)
          .where('searchKeywords', arrayContainsAny: searchTerms)
          .limit(10)
          .get();

      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs
            .map((document) => ProductModel.fromSnapshot(document))
            .toList();
      }
      return [];
    } on FirebaseException catch (e) {
      throw CFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw CFormatException();
    } on PlatformException catch (e) {
      throw CPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
