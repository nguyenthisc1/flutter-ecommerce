import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModel {
  String id;
  String name;
  String image;
  bool? isFeatured;
  int? productCount;

  BrandModel({
    required this.id,
    required this.name,
    required this.image,
    this.isFeatured,
    this.productCount,
  });

  // EMPTY HELPER FUNCTION
  static BrandModel empty() => BrandModel(id: '', name: '', image: '');

  // CONVERT MODEL TO JSON
  toJson() {
    return {
      'Id': id,
      'Name': name,
      'Image': image,
      'IsFeatured': isFeatured,
      'ProductCount': productCount,
    };
  }

  // MAP JSON ORIENTED DOCUMENT SNAPSHOT FROM FIREBASE
  factory BrandModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return BrandModel.empty();
    return BrandModel(
      id: data['Id'] ?? '',
      name: data['Name'] ?? '',
      image: data['Image'] ?? '',
      isFeatured: data['IsFeatured'] ?? false,
      productCount: int.parse((data['ProductCount'] ?? 0).toString()),
    );
  }

  // MAP JSON ORIENTED DOCUMENT SNAPSHOT FROM FIREBASE TO USERMODEL
  factory BrandModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      // MAP JSON RECORD TO THE MODEL
      return BrandModel(
        id: document.id,
        name: data['Name'] ?? '',
        image: data['Image'] ?? '',
        isFeatured: data['IsFeatured'] ?? false,
        productCount: int.parse((data['ProductCount'] ?? 0).toString()),
      );
    } else {
      return BrandModel.empty();
    }
  }
}
