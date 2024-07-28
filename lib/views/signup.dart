import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hse_app/utiles/text_styles.dart';
import 'package:hse_app/views/login.dart';
import 'package:hse_app/widgets/custom_appbar.dart';
import 'package:hse_app/widgets/custom_textformfield.dart';
import 'package:hse_app/widgets/successful_send.dart';

class Signup extends StatefulWidget {
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();
  final TextEditingController firstcontroller = TextEditingController();
  final TextEditingController secoundnamecontroller = TextEditingController();
  final TextEditingController InviteController = TextEditingController();
  String? governorate;
  String? neighborhood;
  CollectionReference Users = FirebaseFirestore.instance.collection('Users');

  Future<void> signup() async {
    if (_formKey.currentState!.validate()) {
      try {
        int phoneNumber = int.parse(controller.text);
        await Users.add({
          "First Name": firstcontroller.text,
          "Secound Name": secoundnamecontroller.text,
          "Phone": phoneNumber,
          "Invetation Code": InviteController.text,
          "Neighborhood": neighborhood,
          "Governorate": governorate,
        });

        await showDialog(
          context: context,
          builder: (context) {
            return SuccssfulSend(
              text: 'تم انشاء الحساب بنجاح',
            );
          },
        );
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return Login();
        }));
      } catch (e) {
        print('Error adding document: $e');
      }
    }
  }

  List<int> phoneNumbers = [];

  Future<void> fetchPhoneNumbers() async {
    try {
      QuerySnapshot querySnapshot = await Users.get();
      setState(() {
        phoneNumbers =
            querySnapshot.docs.map((doc) => doc['Phone'] as int).toList();
      });
      print('Phone Numbers: $phoneNumbers');
    } catch (e) {
      print('Error fetching phone numbers: $e');
    }
  }

  String? validatePhoneNumber(String? number) {
    if (number == null || number.isEmpty) {
      return 'برجاء ادخال رقم الجوال';
    }
    if (number.length != 13) {
      return 'رقم الجوال يجب أن يكون 13 أرقام';
    }
    int? phoneNumber = int.tryParse(number);
    if (phoneNumber == null) {
      return 'برجاء إدخال رقم صالح';
    }
    if (phoneNumbers.contains(phoneNumber)) {
      return 'هزا الرقم مستخدم من قبل';
    }
    return null;
  }

  @override
  void dispose() {
    firstcontroller.dispose();
    secoundnamecontroller.dispose();
    controller.dispose();
    InviteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        image1: 'assets/Menu.png',
        text: 'إنشاء حساب',
        image2: 'assets/HSE  LOGO.png',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'الإسم الأخير',
                            style: TextStyle(
                                fontFamily: 'Tajawal',
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(height: 8),
                          CustomTextFormField(
                              controller: firstcontroller,
                              text: 'الإسم الأخير',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'يرجى إدخال الإسم الأخير';
                                }
                                return null;
                              }),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'الإسم الأول',
                            style: TextStyle(
                                fontFamily: 'Tajawal',
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(height: 8),
                          CustomTextFormField(
                              controller: secoundnamecontroller,
                              text: 'الإسم الأول',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'يرجى إدخال الإسم الأول';
                                }
                                return null;
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'رقم الموبايل',
                    // textAlign: TextAlign.,
                    style: TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller,
                        keyboardType: TextInputType.phone,
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
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 12),
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
                        validator: validatePhoneNumber,
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
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'المحافظة',
                    style: TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  width: 358,
                  height: 56,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 255, 255, 1),
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(33, 33, 33, 0.08),
                        blurRadius: 16.0,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        hintText: ' المحافظة ',
                        border: InputBorder.none,
                      ),
                      icon: const Icon(
                        Icons.keyboard_arrow_down_sharp,
                        size: 30,
                        color: Color.fromRGBO(251, 186, 0, 1),
                      ),
                      items: ['Option 1', 'Option 2', 'Option 3']
                          .map((option) => DropdownMenuItem(
                                value: option,
                                child: Text(option),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          governorate = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'يرجى اختيار المحافظة';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'الحى (إختيارى)',
                    style: TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  width: 358,
                  height: 56,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 255, 255, 1),
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(33, 33, 33, 0.08),
                        blurRadius: 16.0,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        hintText: 'الحى ',
                        border: InputBorder.none,
                      ),
                      icon: const Icon(
                        Icons.keyboard_arrow_down_sharp,
                        size: 30,
                        color: Color.fromRGBO(251, 186, 0, 1),
                      ),
                      items: ['Option 1', 'Option 2', 'Option 3']
                          .map((option) => DropdownMenuItem(
                                value: option,
                                child: Text(option),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          neighborhood = value;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'كود الدعوة (إختيارى)',
                    style: TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                CustomTextFormField(
                    controller: InviteController, text: 'IOFPDPFDFM8DFLDXX'),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: 190,
                    height: 56,
                    decoration: const BoxDecoration(boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 4),
                          blurRadius: 8,
                          spreadRadius: 4,
                          color: Color.fromRGBO(255, 186, 0, 0.24))
                    ]),
                    child: MaterialButton(
                      elevation: 1,
                      onPressed: () {
                        signup();
                        fetchPhoneNumbers();
                      },
                      color: const Color.fromRGBO(255, 186, 0, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          'ارسل',
                          style: TextStyle(
                              fontFamily: 'Tajawal',
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'تسجيل الدخول',
                        style: TextStyle(
                            fontFamily: 'Tajawal',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(251, 186, 0, 1)),
                      ),
                    ),
                    const Text(
                      'لديك حساب؟',
                      style: TextStyle(
                          fontFamily: 'Tajawal',
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: Color.fromRGBO(140, 140, 140, 1)),
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'By ',
                      style: TextStyle(
                          fontFamily: 'Tajawal',
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                    Transform.translate(
                      offset: const Offset(0.0, -5.0),
                      child: Image.asset(
                        'assets/Qara_Logo.png',
                        height: 24,
                        width: 55,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
