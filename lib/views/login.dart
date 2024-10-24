import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:hse_app/utiles/text_styles.dart';
import 'package:hse_app/views/home.dart';
import 'package:hse_app/views/signup.dart';
import 'package:hse_app/widgets/create_account.dart';
import 'package:hse_app/widgets/custom_appbar.dart';
import 'package:pinput/pinput.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _verificationId;
  bool _isOtpSent = false;
  String _selectedCountryCode = '+966';
  Future<void> _submitPhoneNumber() async {
    String phoneNumber = _selectedCountryCode + _phoneController.text.trim();
    FirebaseAuth auth = FirebaseAuth.instance;
    final firestore = FirebaseFirestore.instance;

    // Check if the phone number exists in Firestore
    final userQuery = await firestore
        .collection('Users')
        .where('Phone', isEqualTo: phoneNumber)
        .get();

    if (userQuery.docs.isEmpty) {
      showDialog(
          context: context,
          builder: (context) {
            return CreateAccount();
          });
      return;
    }

    // Proceed with OTP verification if phone number exists
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const HomeView()),
        );
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message.toString());
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          _verificationId = verificationId;
          _isOtpSent = true;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 48,
      height: 48,
      textStyle: const TextStyle(
          fontSize: 32,
          color: Colors.white,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(245, 245, 245, 1),
        border: Border.all(
          color: const Color.fromRGBO(245, 245, 245, 1),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(
        color: const Color.fromRGBO(245, 245, 245, 1),
      ),
      borderRadius: BorderRadius.circular(12),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(236, 103, 7, 1),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
        text: 'تسجيل دخول',
        image2: 'assets/hse.png',
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 15),
              Center(child: Image.asset('assets/Phone Icon.png')),
              const SizedBox(height: 20),
              const Align(
                child: Text(
                  'قم بإدخال رقم الجوال!',
                  style: TextStyles.styleNormal16,
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                ),
              ),
              const SizedBox(height: 10),
              const Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'رقم الموبايل',
                  style: TextStyles.styleNormal16,
                  textDirection: TextDirection.rtl,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _phoneController,
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
                      validator: (number) {
                        if (number == null || number.isEmpty) {
                          return 'برجاء ادخال رقم الجوال';
                        }
                        if (number.length < 9 || number.length > 10) {
                          return 'رقم الجوال يجب أن يكون 9 أو 10 أرقام';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        color: Color.fromRGBO(245, 245, 245, 1)),
                    child: CountryCodePicker(
                      onChanged: (country) {
                        setState(() {
                          _selectedCountryCode = country.dialCode!;
                        });
                      },
                      initialSelection: 'SA',
                      favorite: ['+966', 'SA'],
                      showCountryOnly: false,
                      showOnlyCountryWhenClosed: false,
                      alignLeft: false,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              if (_isOtpSent)
                Column(
                  children: [
                    const Text(
                      'أدخل الرمز المكون من ٦ أرقام الذي أرسلناه',
                      style: TextStyles.styleNormal16,
                    ),
                    const SizedBox(height: 27),
                    Pinput(
                      length: 6,
                      controller: _otpController,
                      defaultPinTheme: defaultPinTheme,
                      focusedPinTheme: focusedPinTheme,
                      submittedPinTheme: submittedPinTheme,
                      onCompleted: (pin) => _submitOtp(),
                    ),
                    const SizedBox(height: 28),
                    Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 4),
                                color: Color.fromRGBO(33, 33, 33, 0.08),
                                blurRadius: 16,
                                spreadRadius: 0)
                          ]),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          minimumSize: const Size(200, 56),
                          backgroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                          shadowColor: Colors.black.withOpacity(0.08),
                          elevation: 4,
                        ),
                        onPressed: _submitOtp,
                        child: const Text(
                          'تاكيد',
                          style: TextStyles.styleBoldorange18,
                        ),
                      ),
                    ),
                  ],
                )
              else
                Container(
                  width: 200,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFF7BA00).withOpacity(0.24),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        _submitPhoneNumber();
                      } else {
                        print('Form is invalid!');
                      }
                    },
                    color: const Color(0xFFF7BA00),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'تأكيد',
                      style: TextStyles.styleNormalwhite18,
                    ),
                  ),
                ),
              const Expanded(child: SizedBox()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return Signup();
                      }));
                    },
                    child: const Text(
                      'إنشاء حساب',
                      style: TextStyle(
                        color: Color.fromRGBO(251, 186, 0, 1),
                        fontSize: 16,
                        fontFamily: 'Tajawal',
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'ليس لديك حساب؟',
                    style: TextStyles.styleNormalgray14,
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Container(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'By',
                      style: TextStyle(fontSize: 8),
                    ),
                    const SizedBox(width: 2),
                    Transform.translate(
                      offset: const Offset(0, -3),
                      child: Image.asset(
                        'assets/Qara_Logo.png',
                        width: 60,
                        height: 24,
                        fit: BoxFit.scaleDown,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitOtp() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String otp = _otpController.text.trim();
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId!,
      smsCode: otp,
    );
    await auth.signInWithCredential(credential);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const HomeView()));
  }
}
