import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hse_app/views/home.dart';
import 'package:hse_app/views/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (_auth.currentUser != null) {
        print('User signed in before');
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) {
            return const HomeView();
          },
        ));
      } else {
        print('User signed out');
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) {
            return Login();
          },
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Expanded(
              child: SizedBox(),
            ),
            Image.asset(
              'assets/splash.png',
              width: 170,
              height: 170,
              fit: BoxFit.scaleDown,
            ),
            const SizedBox(
              height: 210,
            ),
            const Text(
              'Powered by',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 8),
            ),
            Transform.translate(
              offset: const Offset(5, 0),
              child: Image.asset(
                'assets/Qara_Logo.png',
                height: 28,
                width: 70,
                fit: BoxFit.scaleDown,
              ),
            ),
            const SizedBox(
              height: 60,
            )
          ],
        ),
      ),
    );
  }
}
