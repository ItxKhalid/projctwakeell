import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyBdXR3C5xkEmW31PahssRKtQjYfpXnne2w',
    appId: '1:435984390450:web:fa00993cdf53c5228cdf2b',
    messagingSenderId: '435984390450',
    projectId: 'wakeel-5dda8',
    authDomain: 'wakeel-5dda8.firebaseapp.com',
    storageBucket: 'wakeel-5dda8.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCSjg_bkPH7XQPr_L0GJBHBTuaMBIRp_lE',
    appId: '1:435984390450:android:a11c5deaf666a5d68cdf2b',
    messagingSenderId: '435984390450',
    projectId: 'wakeel-5dda8',
    storageBucket: 'wakeel-5dda8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDHXE2VMHQJooVxMUuKoEsOHg4jKQfedTY',
    appId: '1:435984390450:ios:ff070d4010cec12b8cdf2b',
    messagingSenderId: '435984390450',
    projectId: 'wakeel-5dda8',
    storageBucket: 'wakeel-5dda8.appspot.com',
    iosBundleId: 'com.example.projctwakeell',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDHXE2VMHQJooVxMUuKoEsOHg4jKQfedTY',
    appId: '1:435984390450:ios:ff070d4010cec12b8cdf2b',
    messagingSenderId: '435984390450',
    projectId: 'wakeel-5dda8',
    storageBucket: 'wakeel-5dda8.appspot.com',
    iosBundleId: 'com.example.projctwakeell',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBdXR3C5xkEmW31PahssRKtQjYfpXnne2w',
    appId: '1:435984390450:web:fee536859cf3ba778cdf2b',
    messagingSenderId: '435984390450',
    projectId: 'wakeel-5dda8',
    authDomain: 'wakeel-5dda8.firebaseapp.com',
    storageBucket: 'wakeel-5dda8.appspot.com',
  );

}