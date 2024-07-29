import 'package:flutter/material.dart';
import 'package:hse_app/utils/text_styles.dart';
import 'package:hse_app/widgets/about_company.dart';
import 'package:hse_app/widgets/custom_appbar.dart';
import 'package:hse_app/widgets/custom_footer.dart';
import 'package:hse_app/widgets/about_app.dart';
import 'package:hse_app/widgets/our_products.dart';

class TopTabbarr extends StatelessWidget {
  const TopTabbarr({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        appBar: CustomAppBar(
          image1: 'assets/Menu.png',
        ),
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                'assets/squares.png',
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 30,
              right: 10,
              left: 20,
              child: Image.asset(
                'assets/hse.png',
                width: 96,
                height: 96,
                fit: BoxFit.scaleDown,
              ),
            ),
            Positioned(
              top: 150,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 150,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(102, 102, 102, 0.08),
                      offset: Offset(0, 0),
                      blurRadius: 32,
                      spreadRadius: 8,
                    ),
                  ],
                ),
                child: const Column(
                  children: [
                    SizedBox(
                      height: 6,
                    ),
                    TabBar(
                      labelStyle: TextStyles.styleNormal16_500,
                      indicatorWeight: 4,
                      indicatorSize: TabBarIndicatorSize.label,
                      labelColor: Color.fromARGB(255, 236, 103, 7),
                      unselectedLabelColor: Color.fromARGB(255, 140, 140, 140),
                      indicatorColor: Color.fromARGB(255, 236, 103, 7),
                      tabs: [
                        Tab(
                          text: 'منتجاتنا',
                        ),
                        Tab(
                          text: 'عن الشركة',
                        ),
                        Tab(
                          text: 'عن التطبيق',
                        ),
                      ],
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: Color.fromARGB(140, 140, 140, 1),
                      indent: 0,
                      endIndent: 0,
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          OurProducts(),
                          AboutCompany(),
                          AboutApp(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const CustomFooter(
              num: 78,
              num2: 24,
            ),
          ],
        ),
      ),
    );
  }
}
