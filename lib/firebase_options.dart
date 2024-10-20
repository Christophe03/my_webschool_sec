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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyDAkpmLIoS4sRhRVQdmEAZTJbeUS-_ElY8',
    appId: '1:551184465841:web:49a4d9811c106c9cb64790',
    messagingSenderId: '551184465841',
    projectId: 'conseilos-ab8ec',
    authDomain: 'conseilos-ab8ec.firebaseapp.com',
    databaseURL: 'https://conseilos-ab8ec-default-rtdb.firebaseio.com',
    storageBucket: 'conseilos-ab8ec.appspot.com',
    measurementId: 'G-L4NM2NC0SV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyALYL_1k9QFBuyhRuBWv0cajzOS7MJT2gs',
    appId: '1:551184465841:android:bd6b9812da18950ab64790',
    messagingSenderId: '551184465841',
    projectId: 'conseilos-ab8ec',
    databaseURL: 'https://conseilos-ab8ec-default-rtdb.firebaseio.com',
    storageBucket: 'conseilos-ab8ec.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDz6OINGiKBhB-RVWIzWFWs_2nzn2QADKI',
    appId: '1:551184465841:ios:e7d8b1b338376f2cb64790',
    messagingSenderId: '551184465841',
    projectId: 'conseilos-ab8ec',
    databaseURL: 'https://conseilos-ab8ec-default-rtdb.firebaseio.com',
    storageBucket: 'conseilos-ab8ec.appspot.com',
    iosBundleId: 'com.example.myWebschoolSec',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDz6OINGiKBhB-RVWIzWFWs_2nzn2QADKI',
    appId: '1:551184465841:ios:e7d8b1b338376f2cb64790',
    messagingSenderId: '551184465841',
    projectId: 'conseilos-ab8ec',
    databaseURL: 'https://conseilos-ab8ec-default-rtdb.firebaseio.com',
    storageBucket: 'conseilos-ab8ec.appspot.com',
    iosBundleId: 'com.example.myWebschoolSec',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDAkpmLIoS4sRhRVQdmEAZTJbeUS-_ElY8',
    appId: '1:551184465841:web:49a4d9811c106c9cb64790',
    messagingSenderId: '551184465841',
    projectId: 'conseilos-ab8ec',
    authDomain: 'conseilos-ab8ec.firebaseapp.com',
    databaseURL: 'https://conseilos-ab8ec-default-rtdb.firebaseio.com',
    storageBucket: 'conseilos-ab8ec.appspot.com',
    measurementId: 'G-L4NM2NC0SV',
  );
}
