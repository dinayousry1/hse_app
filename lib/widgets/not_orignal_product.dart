import 'package:flutter/material.dart';
import 'package:hse_app/utiles/text_styles.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class NotOriginalProduct extends StatelessWidget {
  const NotOriginalProduct({super.key, this.controller});
  final QRViewController? controller;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18), topRight: Radius.circular(18)),
      ),
      child: SizedBox(
        width: 390,
        height: 320,
        child: Column(
          children: [
            const SizedBox(height: 5),
            Container(
              width: 96,
              height: 5,
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(251, 186, 0, 1),
                  borderRadius: BorderRadius.all(Radius.circular(3))),
            ),
            SizedBox(
                width: 190,
                height: 190,
                child: Image.asset('assets/alert.gif')),
            const SizedBox(height: 5),
            const Text(
              '..إحذر',
              style: TextStyles.styleNormalRed16,
            ),
            const SizedBox(height: 8),
            const Text(
              'المنتج غير أصلى! من فضلك تأكد من المنتج',
              textAlign: TextAlign.center,
              style: TextStyles.styleNormal16,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  controller?.resumeCamera();
                },
                child: const Text(
                  'OK',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
