import 'package:flutter/material.dart';
import 'package:hse_app/widgets/company_describtion.dart';

class AboutCompany extends StatelessWidget {
  const AboutCompany({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CompanyDescription(
              text:
                  'تأسست شركة HSE، شركة هشام السويدى للهندسة والتوزيع، في أوائل عام 1960 فى المملكة العربية السعودية متخصصة في تجارة الكابلات ومستلزمات المواد الكهربائية.',
            ),
            SizedBox(height: 15),
            Divider(thickness: 1, endIndent: 10, indent: 10),
            SizedBox(height: 15),
            CompanyDescription(
              text:
                  'نحن فخورون بأن نكون أحد الرواد في مجال عملنا في المملكة العربية السعودية والخليج والشرق الأوسط. منذ بداياتنا المتواضعة، تطورنا الآن لنصبح البائع الأول للكابلات والمواد الكهربائية.',
            ),
            SizedBox(height: 15),
            Divider(thickness: 1, endIndent: 10, indent: 10),
            SizedBox(height: 15),
            CompanyDescription(
              text:
                  'مع أكثر من 50 عامًا من الخبرة في الصناعة، والتغطية الإقليمية الواسعة، وموظفي الدعم المدربين جيدًا ومجموعة منتجاتنا المتنوعة، نحن فخورون بأن نكون مصدرك الموثوق به لجميع منتجاتك الكهربائية.',
            ),
            SizedBox(height: 15),
            Divider(thickness: 1, endIndent: 10, indent: 10),
            SizedBox(height: 15),
            CompanyDescription(
              text:
                  'تتلخص أهدافنا في أن تكون شركة رائدة في توفير الحلول لعملائنا في جميع أنحاء العالم فيما يتعلق بمتطلباتهم المتعلقة بالمنتجات الكهروميكانيكية.',
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
