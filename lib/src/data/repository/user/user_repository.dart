
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:smartprayer/src/exception/platform_exceptions.dart';

import '../../../exception/firebase_exceptions.dart';
import '../../model/user_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Function to save user data to Firestore.
  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection("Users").doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on FormatException {
      throw const FormatException();
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (_) {
      throw ('Something went wrong. Please try again');
    }
  }
}
