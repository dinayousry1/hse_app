import 'package:flutter/material.dart';
import 'package:hse_app/product.dart';
import 'package:hse_app/utiles/text_styles.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class OrignalProduct extends StatelessWidget {
  final QRViewController? controller;
  final Product product;

  const OrignalProduct({
    super.key,
    this.controller,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: SizedBox(
        width: 400,
        height: 335,
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
              // product.image ??
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
                            return ProductDetails(product: product);
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
                        controller?.resumeCamera();
                      },
                      style: TextButton.styleFrom(
                        minimumSize: const Size(120, 40),
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
  final Product product;

  const ProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.7,
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
            const SizedBox(height: 15),
            Image.network(
              product.image ?? 'assets/orignal_product.png',
              width: 190,
              height: 190,
              fit: BoxFit.scaleDown,
            ),
            const SizedBox(height: 5),
            Text(
              'منتج أصلى',
              style: TextStyles.stylethinWhite18,
            ),
            const SizedBox(height: 8),
            const Divider(
              thickness: 1.5,
              color: Color.fromRGBO(236, 236, 236, 1),
              indent: 12,
              endIndent: 12,
            ),
            const SizedBox(height: 10),
            Text(
              product.name ?? 'كابل السويدى',
              style: TextStyles.styleBoldBlack18,
            ),
            const SizedBox(height: 16),
            Image.asset(
              'assets/copper-wire 2.png',
              width: 64,
              height: 64,
              fit: BoxFit.scaleDown,
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.12,
              width: MediaQuery.of(context).size.width * 0.7,
              child: Column(
                children: product.values!
                    .map(
                      (attr) => Container(
                        height: MediaQuery.of(context).size.height * 0.04,
                        color: product.values!.indexOf(attr) % 2 == 0
                            ? const Color.fromRGBO(236, 236, 236, 1)
                            : Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                attr.value?.name ?? '',
                                style: TextStyles.styleNormal16_500,
                              ),
                              Text(
                                attr.key?.name ?? '',
                                style: TextStyles.styleNormal14,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class ProductDetails extends StatelessWidget {
//   final Product product;

//   const ProductDetails({super.key, required this.product});

//   @override
//   Widget build(BuildContext context) {
//     // Assuming product.name is a string like "14awg/500ft/red"
//     final attributes = product.name?.split('/') ?? [];
//     final attributeLabels = ['المقاس', 'الطول', 'اللون'];

//     return Dialog(
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(20), topRight: Radius.circular(20)),
//       ),
//       child: SizedBox(
//         width: MediaQuery.of(context).size.width * 0.8,
//         height: MediaQuery.of(context).size.height * 0.7,
//         child: Column(
//           children: [
//             const SizedBox(height: 5),
//             Container(
//               width: 96,
//               height: 5,
//               decoration: const BoxDecoration(
//                   color: Color.fromRGBO(251, 186, 0, 1),
//                   borderRadius: BorderRadius.all(Radius.circular(3))),
//             ),
//             const SizedBox(height: 15),
//             Image.network(
//               product.image ?? 'assets/orignal_product.png',
//               width: 190,
//               height: 190,
//               fit: BoxFit.scaleDown,
//             ),
//             const SizedBox(height: 5),
//             Text(
//               'منتج أصلى',
//               style: TextStyles.stylethinWhite18,
//             ),
//             const SizedBox(height: 8),
//             const Divider(
//               thickness: 1.5,
//               color: Color.fromRGBO(236, 236, 236, 1),
//               indent: 12,
//               endIndent: 12,
//             ),
//             const SizedBox(height: 10),
//             Text(
//               product.name ?? 'كابل السويدى',
//               style: TextStyles.styleBoldBlack18,
//             ),
//             const SizedBox(height: 16),
//             Image.asset(
//               'assets/copper-wire 2.png',
//               width: 64,
//               height: 64,
//               fit: BoxFit.scaleDown,
//             ),
//             const SizedBox(height: 20),
//             SizedBox(
//               height: MediaQuery.of(context).size.height * 0.12,
//               width: MediaQuery.of(context).size.width * 0.7,
//               child: Column(
//                 children: List.generate(
//                   attributes.length,
//                   (index) {
//                     return Container(
//                       height: MediaQuery.of(context).size.height * 0.04,
//                       color: index % 2 == 0
//                           ? const Color.fromRGBO(236, 236, 236, 1)
//                           : Colors.white,
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 8, right: 8),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               attributes[index],
//                               style: TextStyles.styleNormal16_500,
//                             ),
//                             Text(
//                               attributeLabels[index],
//                               style: TextStyles.styleNormal14,
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }