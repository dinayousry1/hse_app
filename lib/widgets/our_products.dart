import 'package:flutter/material.dart';
import 'package:hse_app/utiles/text_styles.dart';
import 'package:hse_app/widgets/product_item.dart';

class OurProducts extends StatelessWidget {
  const OurProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'ستجد الأكواد على منتجات:',
                style: TextStyles.styleNormal18,
                textDirection: TextDirection.rtl,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            ProductItem(
              text1: 'أسلاك',
              text2: 'assets/wires.png',
            ),
            SizedBox(
              height: 12,
            ),
            ProductItem(
              text1: 'إضاءات',
              text2: 'assets/thing.png',
            ),
            SizedBox(
              height: 12,
            ),
            ProductItem(
              text1: 'علب كهرباء',
              text2: 'assets/Tye.png',
            ),
            SizedBox(
              height: 12,
            ),
            ProductItem(
              text1: 'مراوح',
              text2: 'assets/van.png',
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
