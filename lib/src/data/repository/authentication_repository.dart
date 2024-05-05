import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smartprayer/src/exception/firebase_auth_exceptions.dart';
import 'package:smartprayer/src/exception/firebase_exceptions.dart';
import 'package:smartprayer/src/exception/platform_exceptions.dart';
import 'package:smartprayer/src/features/authentication/screens/onboarding/onboarding.dart';
import 'package:smartprayer/src/screens/email_verifcation.dart';
import 'package:smartprayer/src/screens/login.dart';
import 'package:smartprayer/src/routing/navigation_menu.dart';

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
        await GoogleSignIn.standard().disconnect();
        await GoogleSignIn.standard().signOut();
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

Future<void> signInWithGoogle() async {
  try {
    print('Starting Google Sign-In process...');

    // Trigger the Google Sign In process
    final googleUser = await GoogleSignIn().signIn().catchError((e) {
      print('Google Sign-In failed: $e');
      throw 'Google Sign-In failed. Please try again.';
    });
    if (googleUser == null) {
      print('Google Sign-In failed: User canceled.');
      return; // Exit the method if sign-in was canceled
    }
    print('Google Sign-In completed successfully.');

    // Obtain the GoogleSignInAuthentication object
    final googleAuth = await googleUser.authentication;
    print('Google authentication obtained.');

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    print('Firebase credential created.');

    // Sign in to Firebase with the Google Auth credential
    print('Signing in to Firebase...');
    final authResult = await FirebaseAuth.instance.signInWithCredential(credential);
    print('Firebase sign-in successful.');

    // Check if the user is a new user
    if (authResult.additionalUserInfo?.isNewUser ?? false) {
      print('New user signed in.');
      // Perform sign-up process for new users here
    } else {
      print('Existing user signed in.');
    }

  } on FirebaseAuthException catch (e) {
    print('FirebaseAuthException occurred: ${e.message}');
    throw SFirebaseAuthException(e.code).message;
  } on FirebaseException catch (e) {
    print('FirebaseException occurred: ${e.message}');
    throw SFirebaseException(e.code).message;
  } on FormatException catch (_) {
    print('FormatException occurred.');
    throw const FormatException();
  } on PlatformException catch (e) {
    print('PlatformException occurred: ${e.message}');

  } catch (e) {
    print('Unknown error occurred: $e');
    throw 'Something went wrong. Please try again';
  }
}