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
      return web;
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD0997Lw2auqf6N7Fu5O-p2AaLfIRFRAGg',
    appId: '1:85612669453:web:f0b56a3a1618985a62c344',
    messagingSenderId: '85612669453',
    projectId: 'healthy-medicine-2',
    authDomain: 'healthy-medicine-2.firebaseapp.com',
    storageBucket: 'healthy-medicine-2.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAQdfAwg-mqRN0KzyE9rik8Svda30nl-UQ',
    appId: '1:85612669453:android:708c102bd84b12b462c344',
    messagingSenderId: '85612669453',
    projectId: 'healthy-medicine-2',
    storageBucket: 'healthy-medicine-2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCHnY20CslAtHLRcFTlcG22VJvUZXw86Mg',
    appId: '1:85612669453:ios:6b2c1efcc17c4e9b62c344',
    messagingSenderId: '85612669453',
    projectId: 'healthy-medicine-2',
    storageBucket: 'healthy-medicine-2.appspot.com',
    iosClientId: '85612669453-aa90frh0bkj1767s09sgl61ltfutj9cu.apps.googleusercontent.com',
    iosBundleId: 'com.example.healthyMedicine2',
  );
}