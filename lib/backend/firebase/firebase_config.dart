import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyD9dJfD8N3jOnT-EwH2-R4V4kwd03cH8KA",
            authDomain: "estufainteligente-366da.firebaseapp.com",
            projectId: "estufainteligente-366da",
            storageBucket: "estufainteligente-366da.appspot.com",
            messagingSenderId: "613859614670",
            appId: "1:613859614670:web:c1741c7a9732d19f8ad59f",
            measurementId: "G-0RVNK23549"));
  } else {
    await Firebase.initializeApp();
  }
}
