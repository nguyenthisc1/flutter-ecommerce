import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/utils/formatters/formatter.dart';

class UserModel {
  final String id;
  final String userName;
  final String email;
  String firstName;
  String lastName;
  String phoneNumber;
  String profilePicture;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
  });

  // HELPER FUNCTION TO GET FULL NAME
  String get fullName => '$firstName $lastName';

  // HELPER FUNCTION TO FORMAT PHONE NUMBER
  String get formattedPhoneNo => TFormatter.formatPhoneNumber(phoneNumber);

  // STATIC FUNCTION TO SPLIT FULL NAME INTO FIRST AND LAST NAME
  static List<String> nameParts(fullName) => fullName.split(" ");

  // STATIC FUNCTION TO CREATE A USERNAME FROM THE FULL NAME
  static String generateUserName(fullname) {
    List<String> nameParts = fullname.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String camelCaseUserName = '$firstName$lastName';
    String userNameWithPrefix = 'cwt_$camelCaseUserName';
    return userNameWithPrefix;
  }

  // STATIC FUNCTION TO CREATE AN EMPTY USER MODEL
  static UserModel empty() => UserModel(
      id: '',
      firstName: '',
      lastName: '',
      userName: '',
      email: '',
      phoneNumber: '',
      profilePicture: '');

  // CONVERT MODEL TO JSON STRUCTURE FOR STARING DATA IN FIREBASE
  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'lastName': lastName,
      'Username': userName,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture,
    };
  }

  // FACTORY METHOD TO CREATE A USERMODEL FROM A FIREBASE DOCUMENT SNAPSHOT
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        firstName: '',
        lastName: data['lastName'] ?? '',
        userName: data['Username'] ?? '',
        email: data['Email'] ?? '',
        phoneNumber: data['PhoneNumber'] ?? '',
        profilePicture: data['ProfilePicture'] ?? '',
      );
    } else {
      return UserModel(
        id: '',
        firstName: '',
        lastName: '',
        userName: '',
        email: '',
        phoneNumber: '',
        profilePicture: '',
      );
    }
  }
}
