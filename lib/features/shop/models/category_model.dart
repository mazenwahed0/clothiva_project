import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String id;
  String name;
  String image;
  String
      parentId; // Parent ID to compare it with Category ID so whatever selected, it'll be able to fetch all the subcategories based on Parent ID
  bool isFeatured;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    this.isFeatured = false,
    this.parentId = '',
  });

  /// Empty Helper Function
  static CategoryModel empty() =>
      CategoryModel(id: '', name: '', image: '', isFeatured: false);

  /// Convert model to Json structure so that you can store data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Image': image,
      'ParentId': parentId,
      'IsFeatured': isFeatured,
    };
  }

  /// Map Json oriented document snapshot from Firebase to Usermodel
  // Note: to Create Multiple Constructors (Name Constructor), We use "Factory method" and after the Class name ".fromSnapshot" or any other name
  factory CategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      // Map JSON Record to the Model
      return CategoryModel(
        id: document.id,
        name: data['Name'] ?? '',
        image: data['Image'] ?? '',
        parentId: data['ParentId'] ?? '',
        isFeatured: data['IsFeatured'] ?? false,
      );
    } else {
      return CategoryModel.empty();
    }
  }
}
