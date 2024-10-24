import 'package:flutter/material.dart';
import 'package:hse_app/utiles/text_styles.dart';

class BannerListview extends StatelessWidget {
  const BannerListview({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.26,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              height: 195,
              width: 345,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(16)),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(33, 33, 33, 0.08),
                    offset: Offset(0, 4),
                    blurRadius: 16,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 0,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(16),
                        bottomLeft: Radius.circular(16),
                      ),
                      child: Image.asset(
                        'assets/curve1.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Image.asset(
                      'assets/Vectors.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 35,
                    left: 193,
                    child: Image.asset(
                      'assets/gifts.png',
                      width: 137.12,
                      height: 125.78,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  Positioned(
                    top: 35,
                    left: 50,
                    child: Column(
                      children: [
                        const Text(
                          'اربح كاش باك',
                          style: TextStyles.styleBoldBlack18,
                        ),
                        Transform.translate(
                          offset: const Offset(14, 3),
                          child: const Text(
                            'ونقاط وهدايا',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Tajawal',
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Transform.translate(
                          offset: const Offset(-20, 0),
                          child: MaterialButton(
                            onPressed: () {},
                            minWidth: 155,
                            height: 44,
                            color: const Color.fromRGBO(255, 186, 0, 1),
                            padding: const EdgeInsets.only(left: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text('سجل إلآن',
                                style: TextStyles.styleBoldWhite18),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(16),
                        bottomLeft: Radius.circular(16),
                      ),
                      child: Image.asset(
                        'assets/curve2.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              height: 195,
              width: 345,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(33, 33, 33, 0.08),
                        offset: Offset(0, 4),
                        blurRadius: 16,
                        spreadRadius: 0)
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
