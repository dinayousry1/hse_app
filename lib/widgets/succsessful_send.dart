import 'package:flutter/material.dart';
import 'package:hse_app/utiles/text_styles.dart';

class SuccssfulSend extends StatelessWidget {
  const SuccssfulSend({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.3,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 120,
              height: 120,
              child: Image.asset('assets/done.gif'),
            ),
            const SizedBox(
              height: 30,
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                'تم الإرسال بنجاح',
                style: TextStyles.styleNormal16_500,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
