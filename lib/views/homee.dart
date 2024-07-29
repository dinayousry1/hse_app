import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hse_app/utiles/text_styles.dart';
import 'package:hse_app/views/login.dart';

class Homee extends StatefulWidget {
  const Homee({super.key});

  @override
  State<Homee> createState() => _HomeeState();
}

class _HomeeState extends State<Homee> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: InkWell(
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Login();
                }));
              },
              child: const Icon(Icons.logout),
            ),
          )
        ],
      ),
      body: const Center(
        child: Text(
          'Hello World',
          style: TextStyles.styleBoldorange18,
        ),
      ),
    );
  }
}
