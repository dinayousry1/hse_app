import 'package:flutter/material.dart';
import 'package:hse_app/utiles/text_styles.dart';
import 'package:hse_app/views/signup.dart';

class CreateAccount extends StatelessWidget {
  const CreateAccount({
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
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.height * 0.39,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
          ),
        ),
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
              height: 15,
            ),
            Image.asset(
              'assets/alert.gif',
              width: 140,
              height: 140,
              fit: BoxFit.scaleDown,
            ),
            const Padding(
              padding: EdgeInsets.only(right: 8, left: 8),
              child: Text(
                'للأسف أنت غير مسجل فى برنامج الحافز أنشئ حساب للإستفادة بالهدايا و الكاش باك',
                style: TextStyles.styleNormal16,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return Signup();
                }));
              },
              height: 45,
              color: const Color(0xFFF7BA00),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              child: const Text(
                'إنشاء حساب',
                style: TextStyles.styleBoldWhite18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
