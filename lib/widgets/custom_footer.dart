import 'package:flutter/material.dart';

class CustomFooter extends StatelessWidget {
  const CustomFooter({
    super.key,
    required this.num,
<<<<<<< HEAD
<<<<<<< HEAD
  });
  final double num;
=======
=======
>>>>>>> origin/auth
    required this.num2,
  });
  final double num;
  final double num2;
<<<<<<< HEAD
>>>>>>> origin/aboutus
=======
>>>>>>> origin/auth

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'By',
                style: TextStyle(fontSize: 8),
              ),
              const SizedBox(
                width: 2,
              ),
              Transform.translate(
                offset: const Offset(0, -3),
                child: Image.asset(
                  'assets/Qara_Logo.png',
                  width: num,
<<<<<<< HEAD
<<<<<<< HEAD
                  height: 16,
=======
                  height: num2,
>>>>>>> origin/aboutus
=======
                  height: num2,
>>>>>>> origin/auth
                  fit: BoxFit.scaleDown,
                ),
              )
            ],
          )),
    );
  }
}
