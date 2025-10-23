import 'dart:io';

import 'package:clothiva_project/features/shop/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../features/shop/models/brand_category_model.dart';
import '../../../features/shop/models/category_model.dart';
import '../../../features/shop/models/product_category_model.dart';
import '../../../utils/constants/keys.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import 'package:dio/dio.dart' as dio;

import '../../../utils/helpers/helper_functions.dart';
import '../../services/storage/cloudinary_service.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  /// Variables
  final _db = FirebaseFirestore.instance;
  final _cloudinaryServices = Get.put(CloudinaryService());

  /// [Upload] - Function to upload list of brand categories
  Future<void> uploadBrandCategory(
      List<BrandCategoryModel> brandCategories) async {
    try {
      for (final brandCategory in brandCategories) {
        await _db
            .collection(CKeys.brandCategoryCollection)
            .doc()
            .set(brandCategory.toJson());
      }
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

  /// [Upload] - Function to upload list of brand categories
  Future<void> uploadProductCategory(
      List<ProductCategoryModel> productCategories) async {
    try {
      for (final productCategory in productCategories) {
        await _db
            .collection(CKeys.productCategoryCollection)
            .doc()
            .set(productCategory.toJson());
      }
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

  /// [UploadCategory] - Function to upload list of categories (Dummy Data)
  Future<void> uploadCategories(List<CategoryModel> categories) async {
    try {
      // Loop through each category
      for (var category in categories) {
        // Get ImageData link from the local assets
        final File image = await CHelperFunctions.assetToFile(category.image);
        // Upload Image and Get its URL
        final dio.Response response = await _cloudinaryServices
            .uploadImage(image, CKeys.categoryFolder, publicId: category.id);
        if (response.statusCode == 200) {
          // Assign URL to Category.image attribute
          category.image = response.data['secure_url'];
        }

        // Store Category in Firestore
        await _db
            .collection(CKeys.categoryCollection)
            .doc(category.id)
            .set(category.toJson());
        print('Category Uploaded: ${category.name}');
      }
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

  /// [FetchCategories] - Function to fetch list of categories
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final query = await _db.collection(CKeys.categoryCollection).get();

      if (query.docs.isNotEmpty) {
        List<CategoryModel> categories = query.docs
            .map((document) => CategoryModel.fromSnapshot(document))
            .toList();
        return categories;
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

  /// [FetchSubCategories] - Function to fetch list of sub categories
  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    try {
      final query = await _db
          .collection(CKeys.categoryCollection)
          .where('ParentId', isEqualTo: categoryId)
          .get();

      if (query.docs.isNotEmpty) {
        List<CategoryModel> categories = query.docs
            .map((document) => CategoryModel.fromSnapshot(document))
            .toList();
        return categories;
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
