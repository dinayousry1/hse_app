import 'package:flutter/material.dart';

/* مصدرك الموثوق لجميع متطلبات المواد الكهربائية الخاصة بك */
abstract class TextStyles {
  static const TextStyle styleNormal18 = TextStyle(
      color: Color.fromRGBO(0, 0, 0, 1),
      fontSize: 18,
      fontFamily: 'Tajawal',
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal);
// app bar
  static const TextStyle styleNormal24 = TextStyle(
      color: Color.fromRGBO(0, 0, 0, 1),
      fontSize: 20,
      fontFamily: 'Tajawal',
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal);
  /* اربح كاش باك */
  static const TextStyle styleBoldBlack18 = TextStyle(
      color: Color.fromRGBO(0, 0, 0, 1),
      fontSize: 18,
      fontFamily: 'Tajawal',
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal);
  // سجل الان
  static const TextStyle styleBoldWhite18 = TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontFamily: 'Tajawal',
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal);
  // منتج اصلي
  // background: rgba(236, 103, 7, 1);

  static const TextStyle stylethinWhite18 = TextStyle(
      color: Color.fromRGBO(236, 103, 7, 1),
      fontSize: 18,
      fontFamily: 'Tajawal',
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal);
  // إحذر..
// المنتج غير أصلى! من فضلك تأكد من المنتج
  static const TextStyle styleNormal16 = TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontFamily: 'Tajawal',
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal);
  // المقاس
  static const TextStyle styleNormal14 = TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontFamily: 'Tajawal',
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal);
}
