import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hse_app/views/inquiries.dart';
import 'package:hse_app/views/login.dart';
import 'package:hse_app/widgets/custom_appbar.dart';
import 'package:hse_app/widgets/custom_footer.dart';

class ConnectUs extends StatelessWidget {
  const ConnectUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        widgett: Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              color: Color.fromRGBO(255, 186, 0, 1),
              boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(255, 186, 0, 0.24),
                    offset: Offset(0, 4),
                    blurRadius: 8,
                    spreadRadius: 4),
              ]),
          child: const Icon(
            Icons.keyboard_arrow_right_sharp,
            size: 30,
          ),
        ),
        text: 'تواصل معنا',
        image2: 'assets/hse.png',
      ),
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return const Inquiries();
              }));
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Image.asset(
                    'assets/Contact us 1.png',
                    width: 358,
                    height: 226,
                    fit: BoxFit.scaleDown,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    width: 358,
                    height: 86,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(16),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(33, 33, 33, 0.08),
                          offset: Offset(0, 4),
                          blurRadius: 16,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'الإستفسارات',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontFamily: 'Tajawal',
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'قم بإرسال إستفسار ألآن',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Tajawal',
                                fontWeight: FontWeight.w300,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Container(
                          width: 54,
                          height: 54,
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(245, 245, 245, 1),
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Image.asset('assets/bad-review.png'),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: InkWell(
                        onTap: () async {
                          await FirebaseAuth.instance.signOut();
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Login();
                          }));
                        },
                        child: const Icon(Icons.logout),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const CustomFooter(
            num: 60,
            num2: 24,
          ),
        ],
      ),
    );
  }
}
