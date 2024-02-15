import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smartprayer/src/exception/firebase_auth_exceptions.dart';
import 'package:smartprayer/src/exception/firebase_exceptions.dart';
import 'package:smartprayer/src/exception/platform_exceptions.dart';
import 'package:smartprayer/src/features/authentication/screens/onboarding/onboarding.dart';
import 'package:smartprayer/src/screens/email_verifcation.dart';
import 'package:smartprayer/src/screens/login.dart';
import 'package:smartprayer/src/utils/navigation_menu.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  screenRedirect() {
    final user = _auth.currentUser;
    if(user != null) {
      if (user.emailVerified) {
        Get.offAll(  const NavigationMenu());
      } else {
        Get.offAll(VerifyEmail(email: _auth.currentUser?.email,));
      }
    }else {
      deviceStorage.writeIfNull('isFirstTime', true);
      deviceStorage.read('isFirstTime') != true
          ? Get.offAll(() => const LoginScreen())
          : Get.offAll(const Onboarding());
    }}
  Future<UserCredential> loginWithEmailandPassword(String email, String password) async{
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
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
  }



  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
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
  }
  Future<void> sendEmailVerifcation() async{

    try {
      return await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
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
  }
    Future<void> logout() async{
      try {
         await FirebaseAuth.instance.signOut();
         Get.offAll(()=> const LoginScreen());
      } on FirebaseAuthException catch (e) {
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
    }
  }

