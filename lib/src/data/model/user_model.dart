import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../helper/formatter.dart';

/// Model class representing user data.

class UserModel {
  final String id;
  String firstName;
  String lastName;
  final String username;
  final String email;
  String phoneNumber;
  String profilePicture;

  /// Constructor for UserModel.
  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
  });

  /// Helper function to get the full name.
  String get fullName => '$firstName $lastName';

  /// Helper function to format phone number.
  String get formattedPhoneNumber => SFormatter.formatPhoneNumber(phoneNumber);

  /// Static function to split full name into first and last name.
  static List<String> nameParts(String fullName) => fullName.split(" ");

  /// Static function to generate a username from the full name.
  static String generateUsername(String fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : '';
    String camelCaseUsername = '$firstName$lastName'; // Combine first and last name
    String usernameWithPrefix = "cat $camelCaseUsername"; // Add "cat" prefix
    return usernameWithPrefix;
    if (kDebugMode) {
      print(e);
    }
  }

  /// Static function to create an empty user model.
  factory UserModel.empty() => UserModel(
    id: '',
    firstName: '',
    lastName: '',
    username: '',
    email: '',
    phoneNumber: '',
    profilePicture: '',
  );

  /// Convert model to JSON structure for storing data in Firebase.
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'profilePicture': profilePicture,
    };
  }

  // Factory method to create a UserModel from a Firebase document snapshot.
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    return UserModel(
      id: document.id,
      firstName: data?['firstName'] ?? '',
      lastName: data?['lastName'] ?? '',
      username: data?['username'] ?? '',
      email: data?['email'] ?? '',
      phoneNumber: data?['phoneNumber'] ?? '',
      profilePicture: data?['profilePicture'] ?? '',
    );
  }
}
