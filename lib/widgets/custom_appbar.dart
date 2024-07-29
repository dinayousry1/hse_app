import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:hse_app/utils/text_styles.dart';
=======
import 'package:hse_app/utiles/text_styles.dart';
>>>>>>> origin/auth

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({super.key, this.image1, this.text, this.image2});

  final String? image1;
  final String? text;
  final String? image2;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        if (image1 != null)
          Transform.translate(
            offset: const Offset(-7, -0),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset(
                image1!,
                width: 50,
                height: 50,
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
      ],
      title: Row(
        children: [
          const Expanded(child: SizedBox()),
          if (text != null)
            Text(
              text!,
              style: TextStyles.styleNormal20,
            ),
        ],
      ),
      leading: image2 != null
          ? Transform.translate(
              offset: const Offset(4, 0),
              child: Image.asset(
                image2!,
                width: 40,
                height: 40,
                fit: BoxFit.scaleDown,
              ),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
