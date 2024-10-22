// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBSaohNY8aK-326c3blHb93ACWnGZ2A9MQ',
    appId: '1:230606801572:android:9509c43369df30fe66f431',
    messagingSenderId: '230606801572',
    projectId: 'smartprayer-4887e',
    storageBucket: 'smartprayer-4887e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB8W5Dmte2NgWJ0lLzsbirqMzSc5r-J91E',
    appId: '1:230606801572:ios:38b46931eda5772b66f431',
    messagingSenderId: '230606801572',
    projectId: 'smartprayer-4887e',
    storageBucket: 'smartprayer-4887e.appspot.com',
    androidClientId: '230606801572-083q97st5erdslrp2ti2gvf71m3pm11t.apps.googleusercontent.com',
    iosClientId: '230606801572-8qiibcc7thlm0rucdk37jek77ol7cm11.apps.googleusercontent.com',
    iosBundleId: 'com.example.smartprayer',
  );
}
