import 'package:flutter/material.dart';
import 'package:hse_app/utiles/text_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({super.key, this.text, this.image2, this.widgett});

  final String? text;
  final String? image2;
  final Widget? widgett;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        if (widgett != null)
          Transform.translate(
            offset: const Offset(-10, -0),
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: widgett),
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
          const SizedBox(
            width: 4,
          )
        ],
      ),
      leading: image2 != null
          ? Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 0, 12),
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
