import 'package:flutter/material.dart';
import 'package:hse_app/utils/text_styles.dart';

class OrignalProduct extends StatelessWidget {
  const OrignalProduct({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18), topRight: Radius.circular(18)),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.45,
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
              'assets/orignal_product.png',
              width: 190,
              height: 190,
              fit: BoxFit.scaleDown,
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              'منتج أصلى',
              style: TextStyles.stylethinWhite18,
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(33, 33, 33, 0.08),
                          offset: Offset(0, 4),
                          blurRadius: 16,
                          spreadRadius: 0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const ProductDetails();
                          },
                        );
                      },
                      style: TextButton.styleFrom(
                        minimumSize: const Size(130, 40),
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: Colors.white,
                      ),
                      child: const Text(
                        'عرض التفاصيل',
                        style: TextStyles.styleBoldorange18,
                      ),
                    )),
                const SizedBox(
                  width: 7,
                ),
                Container(
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(255, 186, 0, 0.24),
                          offset: Offset(0, 4),
                          blurRadius: 8,
                          spreadRadius: 4,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                        minimumSize: const Size(130, 40),
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: const Color.fromRGBO(255, 186, 0, 1),
                      ),
                      child: const Text(
                        'مسح كود اخر',
                        style: TextStyles.styleBoldWhite18,
                      ),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18), topRight: Radius.circular(18)),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.68,
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
              'assets/orignal_product.png',
              width: 190,
              height: 190,
              fit: BoxFit.scaleDown,
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              'منتج أصلى',
              style: TextStyles.stylethinWhite18,
            ),
            const SizedBox(
              height: 8,
            ),
            const Divider(
              thickness: 1.5,
              color: Color.fromRGBO(236, 236, 236, 1),
              indent: 12,
              endIndent: 12,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'كابل السويدى',
              style: TextStyles.styleBoldBlack18,
            ),
            const SizedBox(
              height: 16,
            ),
            Image.asset(
              'assets/copper-wire 2.png',
              width: 64,
              height: 64,
              fit: BoxFit.scaleDown,
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.12,
              width: MediaQuery.of(context).size.width * 0.7,
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.04,
                    color: const Color.fromRGBO(236, 236, 236, 1),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          ' 10 AWG',
                          style: TextStyles.styleNormal14,
                        ),
                        Text(
                          ' المقاس ',
                          style: TextStyles.styleNormal14,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.04,
                    color: Colors.white,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          ' 250 FT',
                          style: TextStyles.styleNormal14,
                        ),
                        Text(
                          ' الطول ',
                          style: TextStyles.styleNormal14,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.04,
                    color: const Color.fromRGBO(236, 236, 236, 1),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          ' اسود',
                          style: TextStyles.styleNormal16_500,
                        ),
                        Text(
                          ' اللون ',
                          style: TextStyles.styleNormal14,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
