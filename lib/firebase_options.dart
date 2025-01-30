// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
    apiKey: 'AIzaSyC7SP2zK9zZ41PNAZXUJv656DuEH8qL5RI',
    appId: '1:675699866308:web:0f378e5ed0e7428d5fe791',
    messagingSenderId: '675699866308',
    projectId: 'thirantask',
    authDomain: 'thirantask.firebaseapp.com',
    storageBucket: 'thirantask.firebasestorage.app',
    measurementId: 'G-N6ZRZ2GVEW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC7ubEPvN5etIYzfassNr2r9OjQYKYlcRM',
    appId: '1:675699866308:android:3e38714fb9cee50f5fe791',
    messagingSenderId: '675699866308',
    projectId: 'thirantask',
    storageBucket: 'thirantask.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyALl6yRtG8QAnOs7AOhrxXKO6flEqi0e8k',
    appId: '1:675699866308:ios:e12b58b7938a5b7e5fe791',
    messagingSenderId: '675699866308',
    projectId: 'thirantask',
    storageBucket: 'thirantask.firebasestorage.app',
    iosBundleId: 'com.example.githubStarsApp',
  );
}
