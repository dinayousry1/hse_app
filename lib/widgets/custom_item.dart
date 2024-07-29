import 'package:flutter/material.dart';
import 'package:hse_app/utils/text_styles.dart';

class CustomItem extends StatelessWidget {
  const CustomItem({
    super.key,
    required this.text1,
    required this.text2,
  });
  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 104,
        height: 104,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(33, 33, 33, 0.08),
                  offset: Offset(0, 4),
                  blurRadius: 16,
                  spreadRadius: 0)
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(245, 245, 245, 1),
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Image.asset(text1),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              text2,
              style: TextStyles.styleNormal12,
            )
          ],
        ),
      ),
    );
  }
}
