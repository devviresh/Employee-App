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
    apiKey: 'AIzaSyBXRW5lIlb-rAKCh639f6vj63QxZmQiWVw',
    appId: '1:442378755689:web:934e4005d7cc026e150cf8',
    messagingSenderId: '442378755689',
    projectId: 'zylu-b92aa',
    authDomain: 'zylu-b92aa.firebaseapp.com',
    storageBucket: 'zylu-b92aa.appspot.com',
    measurementId: 'G-VVNHQW6YXY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDK9JA0T0Pg4dH47nBBGbuU_JyPkQmLejU',
    appId: '1:442378755689:android:e64384e9fe197c79150cf8',
    messagingSenderId: '442378755689',
    projectId: 'zylu-b92aa',
    storageBucket: 'zylu-b92aa.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyATM4fDAUP3X1M-EXNInvHmNJEdSRTWOgU',
    appId: '1:442378755689:ios:1d2935468dbd8e3b150cf8',
    messagingSenderId: '442378755689',
    projectId: 'zylu-b92aa',
    storageBucket: 'zylu-b92aa.appspot.com',
    iosBundleId: 'com.example.employeeApp',
  );
}
