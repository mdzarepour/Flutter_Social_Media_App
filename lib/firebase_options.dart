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
    apiKey: 'AIzaSyCo86lm25AEzEvhQtFBHYCTjZU2vfDOQnA',
    appId: '1:178173300525:web:ca198e5446ec18c6478da4',
    messagingSenderId: '178173300525',
    projectId: 'fluttersocialconnectionapp',
    authDomain: 'fluttersocialconnectionapp.firebaseapp.com',
    storageBucket: 'fluttersocialconnectionapp.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCkCi5_PatIcLGRSsoFmkD0GAvCGeOA7L0',
    appId: '1:178173300525:android:c600efe11f82a0b3478da4',
    messagingSenderId: '178173300525',
    projectId: 'fluttersocialconnectionapp',
    storageBucket: 'fluttersocialconnectionapp.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBN8Gy22e73JaOnfuaSizzPPabcn2Y3w44',
    appId: '1:178173300525:ios:884fcd2c963815e7478da4',
    messagingSenderId: '178173300525',
    projectId: 'fluttersocialconnectionapp',
    storageBucket: 'fluttersocialconnectionapp.firebasestorage.app',
    iosBundleId: 'com.example.socialConnection',
  );
}
