import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smartprayer/src/data/repository/authentication_repository.dart';
import 'package:smartprayer/src/popups/loader.dart';
import 'package:smartprayer/src/screens/success.dart';

import '../../../exception/firebase_auth_exceptions.dart';
import '../../../exception/firebase_exceptions.dart';
import '../../../exception/platform_exceptions.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

// timer for auto

  @override
  void onInit() {
    sendEmailVerifcation();
    setTimerForAutoRedirect();
    super.onInit();
  }

//email ver link
  sendEmailVerifcation() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerifcation();
      MySnackBar.SuccessSnackBar(
          title: 'Email Sent!',
          message: 'Please Check Your Inbox and Verify Email');
    } catch (e) {
      MySnackBar.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  setTimerForAutoRedirect() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.off(() => const VerificationSuccessfull());
      }
    });
  }
  checkEmailVerifcationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    try{
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(() => const VerificationSuccessfull());
    }}on FirebaseAuthException catch (e) {
      throw SFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const FormatException();
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (_) {
      throw 'Something went wrong. Please try again';
    }
  }}

