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
    apiKey: 'AIzaSyD2AzwNhdjgJP5-SGbL9ikLgAzmIt18JV8',
    appId: '1:632131837265:web:98efe3ed2504ae0ef30770',
    messagingSenderId: '632131837265',
    projectId: 'chatapp-eba5c',
    authDomain: 'chatapp-eba5c.firebaseapp.com',
    storageBucket: 'chatapp-eba5c.appspot.com',
    measurementId: 'G-51D2RJB59V',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAM3tah_ZnQNRR1AKIlrKVF0rehqtC2EWo',
    appId: '1:632131837265:android:6fbb2668df911337f30770',
    messagingSenderId: '632131837265',
    projectId: 'chatapp-eba5c',
    storageBucket: 'chatapp-eba5c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDrTTZ4pTFC-3y_So8FF4FO18JcbZpH6iY',
    appId: '1:632131837265:ios:3c83325121b85f65f30770',
    messagingSenderId: '632131837265',
    projectId: 'chatapp-eba5c',
    storageBucket: 'chatapp-eba5c.appspot.com',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDrTTZ4pTFC-3y_So8FF4FO18JcbZpH6iY',
    appId: '1:632131837265:ios:9d230ce051b2367ef30770',
    messagingSenderId: '632131837265',
    projectId: 'chatapp-eba5c',
    storageBucket: 'chatapp-eba5c.appspot.com',
    iosBundleId: 'com.example.chatApp.RunnerTests',
  );
}
