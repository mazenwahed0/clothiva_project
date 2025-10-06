import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../features/shop/models/banner_model.dart';
import '../../../utils/constants/keys.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import '../../../utils/helpers/helper_functions.dart';
import 'package:dio/dio.dart' as dio;

import '../../services/storage/cloudinary_service.dart';

class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find();

  /// Variables
  final _db = FirebaseFirestore.instance;
  final _cloudinaryServices = Get.put(CloudinaryService());

  /// [UploadBanners] - Function to upload list of banners
  Future<void> uploadBanners(List<BannerModel> banners) async {
    try {
      for (final banner in banners) {
        // Create a new doc reference to get the auto-generated ID
        final doc = await _db.collection(CKeys.bannerCollection).doc();
        final bannerId = doc.id; // Firestore auto ID

        // convert assetPath to File
        File image = await CHelperFunctions.assetToFile(banner.imageUrl);

        // Upload banner image to cloudinary
        dio.Response response = await _cloudinaryServices
            .uploadImage(image, CKeys.bannersFolder, publicId: bannerId);
        if (response.statusCode == 200) {
          banner.imageUrl = response.data['secure_url'];
        }

        // Save banner to Firestore using the SAME doc
        await doc.set(banner.toJson());
        // If used that it'll generate the file up with x code but regenerate it with y here
        // await _db.collection(CKeys.bannerCollection).doc().set(banner.toJson());
        // That’s why Firestore document ID and Cloudinary publicId are different.

        print('Banner Uploaded: ${banner.imageUrl}');
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

  /// [FetchBanners] - Function to fetch all active banners only
  Future<List<BannerModel>> fetchActiveBanners() async {
    try {
      final query = await _db
          .collection(CKeys.bannerCollection)
          .where('active', isEqualTo: true)
          .get();
      if (query.docs.isNotEmpty) {
        List<BannerModel> banners = query.docs
            .map((document) => BannerModel.fromDocument(document))
            .toList();
        return banners;
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
