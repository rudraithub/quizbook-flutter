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
        return macos;
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
    apiKey: 'AIzaSyCjtsv6U1d4DoOk302TecQEe6a6ffomHnI',
    appId: '1:409696356486:web:345c90666281584c5c6907',
    messagingSenderId: '409696356486',
    projectId: 'quizbook-b6c9f',
    authDomain: 'quizbook-b6c9f.firebaseapp.com',
    storageBucket: 'quizbook-b6c9f.appspot.com',
    measurementId: 'G-RRE4X7LTCY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAQxNiX4Nfcj-BT0I7L3Nbj86om7UqpjTI',
    appId: '1:409696356486:android:5e4248bdcbf31e4d5c6907',
    messagingSenderId: '409696356486',
    projectId: 'quizbook-b6c9f',
    storageBucket: 'quizbook-b6c9f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDJhejFD-KRPLl5rmekCJqzuhKROEJsCW8',
    appId: '1:409696356486:ios:cb1681f5d8fe99455c6907',
    messagingSenderId: '409696356486',
    projectId: 'quizbook-b6c9f',
    storageBucket: 'quizbook-b6c9f.appspot.com',
    iosBundleId: 'com.example.rudraItHub',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDJhejFD-KRPLl5rmekCJqzuhKROEJsCW8',
    appId: '1:409696356486:ios:e1fc280819fa0b315c6907',
    messagingSenderId: '409696356486',
    projectId: 'quizbook-b6c9f',
    storageBucket: 'quizbook-b6c9f.appspot.com',
    iosBundleId: 'com.example.rudraItHub.RunnerTests',
  );
}
