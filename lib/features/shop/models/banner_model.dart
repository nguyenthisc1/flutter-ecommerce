import 'package:cloud_firestore/cloud_firestore.dart';

class BannerModel {
  String imageUrl;
  String targetScreen;
  bool active;

  BannerModel({
    required this.imageUrl,
    required this.targetScreen,
    this.active = false,
  });

  // EMPTY HELPER FUNCTION
  static BannerModel empty() => BannerModel(imageUrl: '', targetScreen: '', active: false);

  // CONVERT MODEL TO JSON STRUCTURE SO THAT YOU CAN STORE DATA IN FIREBASE
  Map<String, dynamic> toJson() {
    return {
      'ImageUrl': imageUrl,
      'TargetScreen': targetScreen,
      'Active': active,
    };
  }

  // MAP JSON ORIENTED DOCUMENT SNAPSHOT FROM FIREBASE TO USER MODEL
  factory BannerModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return BannerModel(
        imageUrl: data['ImageUrl'] ?? '',
        targetScreen: data['TargetScreen'] ?? '',
        active: data['Active'] ?? '',
      );
    } else {
      return BannerModel.empty();
    }
  }
}
