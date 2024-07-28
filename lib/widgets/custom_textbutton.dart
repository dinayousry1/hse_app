import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.widget,
    required this.color,
    required this.onPressed,
  });
  final Widget widget;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 358,
      height: 56,
      child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            backgroundColor: color,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
              Radius.circular(12),
            )),
            // side:
            // const BorderSide(
            //   color: Color(0xFFFEF1CC),
            //   width: 1,
            // ),
          ),
          child: widget
          //
          ),
    );
  }
}
