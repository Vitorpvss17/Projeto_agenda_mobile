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
    apiKey: 'AIzaSyDBDt-MYVXG-dks20pTdhGkTUuAsSLaaZA',
    appId: '1:860351194755:web:4892383b13699440209db6',
    messagingSenderId: '860351194755',
    projectId: 'projeto-diario-pjd',
    authDomain: 'projeto-diario-pjd.firebaseapp.com',
    storageBucket: 'projeto-diario-pjd.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCpFwmS7TBK6CFtgIJB_QaIHn5_JpeqwOo',
    appId: '1:860351194755:android:43ffbe46dea8d1d2209db6',
    messagingSenderId: '860351194755',
    projectId: 'projeto-diario-pjd',
    storageBucket: 'projeto-diario-pjd.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBQXJZtAhAxsbaF5WnKZhGh6e0Zqfu_Dxc',
    appId: '1:860351194755:ios:f198d04bc8f07fe6209db6',
    messagingSenderId: '860351194755',
    projectId: 'projeto-diario-pjd',
    storageBucket: 'projeto-diario-pjd.appspot.com',
    iosBundleId: 'com.example.projetoDiario',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBQXJZtAhAxsbaF5WnKZhGh6e0Zqfu_Dxc',
    appId: '1:860351194755:ios:f33c3dc18036c8ee209db6',
    messagingSenderId: '860351194755',
    projectId: 'projeto-diario-pjd',
    storageBucket: 'projeto-diario-pjd.appspot.com',
    iosBundleId: 'com.example.projetoDiario.RunnerTests',
  );
}
