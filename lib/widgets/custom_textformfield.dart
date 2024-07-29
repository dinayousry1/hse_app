import 'package:hse_app/utils/text_styles.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.text,
    this.validator,
  });

  final TextEditingController controller;
  final String text;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textDirection: TextDirection.rtl,
      style: const TextStyle(
        fontFamily: 'Tajawal',
        fontSize: 16,
        fontWeight: FontWeight.w300,
        height: 2,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        hintTextDirection: TextDirection.rtl,
        hintText: text,
        hintStyle: TextStyles.styleNormalgray14,
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color.fromRGBO(236, 236, 236, 1),
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color.fromRGBO(236, 236, 236, 1),
            width: 1.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.0,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.0,
          ),
        ),
      ),
      validator: validator,
    );
  }
}
