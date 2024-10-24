import 'package:flutter/material.dart';
import 'package:hse_app/utiles/text_styles.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.text1,
    required this.text2,
  });
  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 358,
      height: 104,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
        border: Border.all(
          width: 1,
          color: const Color.fromRGBO(236, 236, 236, 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            text1,
            style: TextStyles.styleNormal16,
          ),
          const SizedBox(width: 8),
          Image.asset(
            text2,
            width: 72,
            height: 72,
            fit: BoxFit.scaleDown,
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }
}
