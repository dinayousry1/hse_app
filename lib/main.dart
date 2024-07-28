import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hse_app/views/Top_tab_bar.dart';
import 'package:hse_app/views/connect_us.dart';
import 'dart:io' as io;

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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ConnectUs(),
    );
  }
}
