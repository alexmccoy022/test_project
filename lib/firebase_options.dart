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
    apiKey: 'AIzaSyD_DWXe-gXUrhlTtA7Tz4fzbvwYxCazs_4',
    appId: '1:339691280494:web:2a55e5360f85d7946a2e7f',
    messagingSenderId: '339691280494',
    projectId: 'tshirts-d2c85',
    authDomain: 'tshirts-d2c85.firebaseapp.com',
    storageBucket: 'tshirts-d2c85.appspot.com',
    measurementId: 'G-VFFHB5TFCH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD8dSK59mys1fS1OxYzvgiyMj83O3u-INg',
    appId: '1:339691280494:android:842f38f5e2903fbe6a2e7f',
    messagingSenderId: '339691280494',
    projectId: 'tshirts-d2c85',
    storageBucket: 'tshirts-d2c85.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBnSMKsJVeixqJV-O2iGz2RXMa3-kBQHoc',
    appId: '1:339691280494:ios:0d90d9631200aeeb6a2e7f',
    messagingSenderId: '339691280494',
    projectId: 'tshirts-d2c85',
    storageBucket: 'tshirts-d2c85.appspot.com',
    iosClientId: '339691280494-82ir943e6umhmi97or66ifoab0716jqv.apps.googleusercontent.com',
    iosBundleId: 'com.example.testProject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBnSMKsJVeixqJV-O2iGz2RXMa3-kBQHoc',
    appId: '1:339691280494:ios:0d90d9631200aeeb6a2e7f',
    messagingSenderId: '339691280494',
    projectId: 'tshirts-d2c85',
    storageBucket: 'tshirts-d2c85.appspot.com',
    iosClientId: '339691280494-82ir943e6umhmi97or66ifoab0716jqv.apps.googleusercontent.com',
    iosBundleId: 'com.example.testProject',
  );
}
