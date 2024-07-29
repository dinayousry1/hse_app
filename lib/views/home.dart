import 'package:flutter/material.dart';
import 'package:hse_app/utils/text_styles.dart';
import 'package:hse_app/views/qrscan.dart';
import 'package:hse_app/widgets/custom_appbar.dart';
import 'package:hse_app/widgets/banner_listview.dart';
import 'package:hse_app/widgets/custom_footer.dart';
import 'package:hse_app/widgets/custom_item.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        text: 'الرئيسية',
        image2: 'assets/HSE  LOGO.png',
      ),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Image.asset(
                        'assets/Group1.png',
                        width: MediaQuery.of(context).size.width * 0.8,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Image.asset(
                        'assets/Group2.png',
                        width: MediaQuery.of(context).size.width * 0.65,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 80),
                          const BannerListview(),
                          const SizedBox(height: 60),
                          const Padding(
                            padding: EdgeInsets.only(right: 11, left: 11),
                            child: Text(
                              'مصدرك الموثوق لجميع متطلبات المواد الكهربائية الخاصة بك',
                              textAlign: TextAlign.center,
                              style: TextStyles.styleNormal18,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomItem(
                                text1: 'assets/phone.png',
                                text2: 'تواصل معنا',
                              ),
                              SizedBox(width: 20),
                              CustomItem(
                                text1: 'assets/Frame 2.png',
                                text2: 'من نحن',
                              ),
                            ],
                          ),
                          const SizedBox(height: 50),
                          const Text(
                            'توثيق منتج',
                            style: TextStyles.styleNormal18,
                          ),
                          const Text(
                            'تأكد من جودة المنتج ومواصفاته',
                            style: TextStyles.styleNormal12_300,
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: 90,
                            height: 90,
                            child: FloatingActionButton(
                              elevation: 0,
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const QRViewExample(),
                                ));
                              },
                              backgroundColor:
                                  const Color.fromRGBO(255, 186, 0, 1),
                              child: Image.asset(
                                'assets/Group.png',
                                width: 33.75,
                                height: 33.75,
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          CustomFooter(
            num: 40, num2: 16,
          ),
        ],
      ),
    );
  }
}
