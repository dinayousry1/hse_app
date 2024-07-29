import 'package:flutter/material.dart';
import 'package:hse_app/utils/text_styles.dart';

class NotOrignalProduct extends StatelessWidget {
  const NotOrignalProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18), topRight: Radius.circular(18)),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.40,
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            Container(
              width: 96,
              height: 5,
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(251, 186, 0, 1),
                  borderRadius: BorderRadius.all(Radius.circular(3))),
            ),
            const SizedBox(
              height: 10,
            ),
            Image.asset(
              'assets/sign.png',
              width: 190,
              height: 190,
              fit: BoxFit.scaleDown,
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              '..إحذر',
              style: TextStyles.styleNormalRed16,
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              'المنتج غير أصلى! من فضلك تأكد من المنتج',
              textAlign: TextAlign.center,
              style: TextStyles.styleNormal16,
            ),
          ],
        ),
      ),
    );
  }
}
