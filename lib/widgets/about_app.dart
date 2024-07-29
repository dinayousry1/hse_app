import 'package:flutter/material.dart';
import 'package:hse_app/utils/text_styles.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppCommen(
              imagePath: 'assets/Frame.png',
              title: 'إفحص المنتج',
              description:
                  'نحن فخورين بأن نكون مصدرك الموثوق به، قم بمسح الكود على منتجات HSE لضمان جودة المنتج و الاستعلام عنه.',
            ),
            AppCommen(
              imagePath: 'assets/books.png',
              title: 'إستخدم وإكسب',
              description:
                  'أنت الآن مسجل في برنامج حوافز HSE،مع كل كود هتمسحه هتكسب حوافز و هدايا، إشترى أكثر، تربح أكثر.',
            ),
            AppCommen(
              imagePath: 'assets/money.png',
              title: 'رشح أصدقائك',
              description:
                  'كل ما ترشح أصدقائك على البرنامج هتكسب كاش باك مع كل إستخدام ليهم.',
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

Widget AppCommen({
  required String imagePath,
  required String title,
  required String description,
}) {
  return Column(
    children: [
      const SizedBox(height: 8),
      Image.asset(
        imagePath,
        width: 116,
        height: 96,
        fit: BoxFit.scaleDown,
      ),
      const SizedBox(height: 10),
      Text(
        title,
        style: TextStyles.styleNormal18,
      ),
      const SizedBox(height: 7),
      Text(
        description,
        style: TextStyles.styleNormalgrey16,
        textAlign: TextAlign.center,
        textDirection: TextDirection.rtl,
      ),
      const SizedBox(height: 4),
      const Divider(
        thickness: 1,
        indent: 10,
        endIndent: 10,
      ),
    ],
  );
}
