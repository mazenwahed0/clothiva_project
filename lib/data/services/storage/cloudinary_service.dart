import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';

import '../../../utils/constants/api_constants.dart';
import '../../../utils/constants/keys.dart';

class CloudinaryService extends GetxController {
  static CloudinaryService get instance => Get.find();

  /// Variables
  final _dio = dio.Dio();

  /// [UploadImage] - Function to upload Image
  Future<dio.Response> uploadImage(
    File image,
    String folderName, {
    String publicId = '',
  }) async {
    try {
      String api = ApiUrls.uploadApi(CKeys.cloudName);

      final formData = dio.FormData.fromMap({
        'upload_preset': CKeys.uploadPreset,
        'folder': folderName,
        'public_id': publicId,
        'file': await dio.MultipartFile.fromFile(
          image.path,
          filename: image.path.split('/').last,
        ),
      });

      dio.Response response = await _dio.post(api, data: formData);
      return response;
    } catch (e) {
      throw 'Failed to upload profile picture. Please try again';
    }
  }

  /// [DeleteImage] - Function to delete Image
  Future<dio.Response> deleteImage(String publicId) async {
    try {
      String api = ApiUrls.deleteApi(CKeys.cloudName);

      int timestamp = (DateTime.now().millisecondsSinceEpoch / 1000).round();

      String signatureBase =
          'public_id=$publicId&timestamp=$timestamp${CKeys.apiSecret}';
      String signature = sha1.convert(utf8.encode(signatureBase)).toString();

      final formData = dio.FormData.fromMap({
        'public_id': publicId,
        'api_key': CKeys.apiKey,
        'timestamp': timestamp,
        'signature': signature,
      });

      dio.Response response = await _dio.post(api, data: formData);

      return response;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
