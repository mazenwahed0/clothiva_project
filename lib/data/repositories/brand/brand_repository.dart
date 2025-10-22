import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../features/shop/models/brand_category_model.dart';
import '../../../features/shop/models/brand_model.dart';
import '../../../utils/constants/keys.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import 'package:dio/dio.dart' as dio;

import '../../../utils/helpers/helper_functions.dart';
import '../../services/storage/cloudinary_service.dart';

class BrandRepository extends GetxController {
  static BrandRepository get instance => Get.find();

  /// Variables
  final _db = FirebaseFirestore.instance;
  final _cloudinaryServices = Get.put(CloudinaryService());

  /// [Upload] - Function to upload all brands
  Future<void> uploadBrands(List<BrandModel> brands) async {
    try {
      for (BrandModel brand in brands) {
        // convert asset path to File
        File brandImage = await CHelperFunctions.assetToFile(brand.image);

        // upload brand image to cloudinary
        dio.Response response = await _cloudinaryServices
            .uploadImage(brandImage, CKeys.brandsFolder, publicId: brand.id);
        if (response.statusCode == 200) {
          brand.image = response.data['secure_url'];
        }

        // store data to Firebase Fire store
        await _db
            .collection(CKeys.brandsCollection)
            .doc(brand.id)
            .set(brand.toJson());
        print('Brands Uploaded: ${brand.name}');
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

  /// [Fetch] - Function to get all brands
  Future<List<BrandModel>> fetchBrands() async {
    try {
      final query = await _db.collection(CKeys.brandsCollection).get();
      if (query.docs.isNotEmpty) {
        List<BrandModel> brands = query.docs
            .map((document) => BrandModel.fromSnapshot(document))
            .toList();
        return brands;
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

  /// [Fetch] - Function to get category specific brands
  Future<List<BrandModel>> fetchBrandsForCategory(String categoryId) async {
    try {
      // Query to get all documents where categoryId matches the provided categoryId
      final brandCategoryQuery = await _db
          .collection(CKeys.brandCategoryCollection)
          .where('categoryId', isEqualTo: categoryId)
          .get();

      // Convert documents to Model
      List<BrandCategoryModel> brandCategories = brandCategoryQuery.docs
          .map((doc) => BrandCategoryModel.fromSnapshot(doc))
          .toList();

      // Extract brandIds from BrandCategoryModel
      List<String> brandIds = brandCategories
          .map((brandCategory) => brandCategory.brandId)
          .toList();

      // Query to get brands based on brandIds
      final brandsQuery = await _db
          .collection(CKeys.brandsCollection)
          .where(FieldPath.documentId, whereIn: brandIds)
          .limit(2)
          .get();

      // convert documents to model
      List<BrandModel> brands =
          brandsQuery.docs.map((doc) => BrandModel.fromSnapshot(doc)).toList();

      return brands;
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

  Future<List<BrandModel>> getAllBrands() async {
    try {
      final snapshot= await _db.collection('Brands').get();
      final result=snapshot.docs.map((e)=>BrandModel.fromSnapshot(e)).toList();
      return result;

    }on FirebaseException catch (e) {
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
