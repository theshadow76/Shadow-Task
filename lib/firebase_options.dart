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
    apiKey: 'AIzaSyBNwOpzQrlTYBA1dNdRw43ZTcEoOQs1y2o',
    appId: '1:701118034049:web:7a4bce9182cafc71349d80',
    messagingSenderId: '701118034049',
    projectId: 'shadowtask-b5b35',
    authDomain: 'shadowtask-b5b35.firebaseapp.com',
    storageBucket: 'shadowtask-b5b35.appspot.com',
    measurementId: 'G-GNCPE376LL',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBrRtTvNMAVdgg0He5YBeXX0OcsEcpd484',
    appId: '1:701118034049:android:b11a457989671a8d349d80',
    messagingSenderId: '701118034049',
    projectId: 'shadowtask-b5b35',
    storageBucket: 'shadowtask-b5b35.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBZYs9WqvOPMh-hWr3yjoFSeM8HYAh9ilY',
    appId: '1:701118034049:ios:1936182d2dbdd553349d80',
    messagingSenderId: '701118034049',
    projectId: 'shadowtask-b5b35',
    storageBucket: 'shadowtask-b5b35.appspot.com',
    iosClientId: '701118034049-6undb393natnpa7q2lo3qupbgtrv93g5.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBZYs9WqvOPMh-hWr3yjoFSeM8HYAh9ilY',
    appId: '1:701118034049:ios:1936182d2dbdd553349d80',
    messagingSenderId: '701118034049',
    projectId: 'shadowtask-b5b35',
    storageBucket: 'shadowtask-b5b35.appspot.com',
    iosClientId: '701118034049-6undb393natnpa7q2lo3qupbgtrv93g5.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterApplication1',
  );
}
