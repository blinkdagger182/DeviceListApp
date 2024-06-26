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
    apiKey: 'AIzaSyAbEI4NvmtCOS5yiPpqLX3gpiCPQTMFt0A',
    appId: '1:386831561783:web:46de152c12539018d3bbb2',
    messagingSenderId: '386831561783',
    projectId: 'compasia-71254',
    authDomain: 'compasia-71254.firebaseapp.com',
    storageBucket: 'compasia-71254.appspot.com',
    measurementId: 'G-7QCFLS3ZW6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCL2IXffO7mVW0wCorhtha-pCjBScl3Al0',
    appId: '1:386831561783:android:271aeb69dc14ac31d3bbb2',
    messagingSenderId: '386831561783',
    projectId: 'compasia-71254',
    storageBucket: 'compasia-71254.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCuMASfzUsqcqGvjsxZ1y2HXD2_YMU0460',
    appId: '1:386831561783:ios:7131a3320232408dd3bbb2',
    messagingSenderId: '386831561783',
    projectId: 'compasia-71254',
    storageBucket: 'compasia-71254.appspot.com',
    iosBundleId: 'com.example.authentication',
  );
}
