import 'package:flutter/material.dart';

class CustomFooter extends StatelessWidget {
  const CustomFooter({
    super.key,
    required this.num,
    required this.num2,
  });
  final double num;
  final double num2;

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
                  height: num2,
                  fit: BoxFit.scaleDown,
                ),
              )
            ],
          )),
    );
  }
}
