import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:hse_app/utiles/text_styles.dart';

class CustomPhoneItem extends StatelessWidget {
  const CustomPhoneItem({
    super.key,
    required TextEditingController phonecontroller,
  }) : _phonecontroller = phonecontroller;

  final TextEditingController _phonecontroller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: TextFormField(
            controller: _phonecontroller,
            keyboardType: TextInputType.phone,
            // textDirection: TextDirection.rtl,
            style: const TextStyle(
              fontFamily: 'Tajawal',
              fontSize: 16,
              fontWeight: FontWeight.w300,
              height: 2,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              hintTextDirection: TextDirection.rtl,
              hintText: 'إكتب رقم جوالك',
              hintStyle: TextStyles.styleNormalgray14,
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color.fromRGBO(236, 236, 236, 1),
                  width: 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color.fromRGBO(236, 236, 236, 1),
                  width: 1.0,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 1.0,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 1.0,
                ),
              ),
            ),
            validator: (number) {
              if (number == null || number.isEmpty) {
                return 'برجاء ادخال رقم الجوال';
              }
              if (number.length != 13) {
                return 'رقم الجوال يجب أن يكون 13 أرقام';
              }
              return null;
            },
          ),

          // CustomTextFormField(
          //   controller: _phonecontroller,
          //   text: 'إكتب رقم جوالك',
          // validator: (number) {
          //   if (number == null || number.isEmpty) {
          //     return 'برجاء ادخال رقم الجوال';
          //   }
          //   if (number.length != 10) {
          //     return 'رقم الجوال يجب أن يكون 10 أرقام';
          //   }
          //   return null;
          // },
          // ),
        ),
        const SizedBox(width: 8),
        Container(
          width: 100,
          height: 56,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              color: Color.fromRGBO(245, 245, 245, 1)),
          child: const FittedBox(
            fit: BoxFit.cover,
            child: CountryCodePicker(
              onChanged: print,
              initialSelection: 'SA',
              favorite: ['+966', 'SA'],
              showCountryOnly: false,
              showOnlyCountryWhenClosed: false,
              alignLeft: false,
            ),
          ),
        ),
      ],
    );
  }
}
