import 'package:flutter/material.dart';
import 'package:hse_app/utils/text_styles.dart';

class CompanyDescription extends StatelessWidget {
  final String text;

  const CompanyDescription({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            text,
            style: TextStyles.styleNormal16,
            softWrap: true,
            textDirection: TextDirection.rtl,
          ),
        ),
        const SizedBox(width: 5),
        Container(
          width: 4,
          height: 80,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(236, 103, 7, 1),
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
        ),
      ],
    );
  }
}
