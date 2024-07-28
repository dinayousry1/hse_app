import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:io' as io;

import 'package:hse_app/views/homee.dart';
import 'package:hse_app/views/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  io.Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: "AIzaSyDYiv6PvZBQ1WuzAqFIqNWuKMg4UUGki5Y",
              appId: "1:542148204838:android:881b44fe3ff7e51414c9e7",
              messagingSenderId: "542148204838",
              projectId: "hse-app-4dfec",
              storageBucket: "hse-app-4dfec.appspot.com"),
        )
      : await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  var _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: _auth.currentUser != null ? Homee() : Login());
  }
}
