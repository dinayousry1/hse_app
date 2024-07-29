import 'package:flutter/material.dart';
import 'package:hse_app/utiles/text_styles.dart';
import 'package:hse_app/views/homee.dart';
import 'package:hse_app/views/signup.dart';
import 'package:hse_app/widgets/custom_appbar.dart';
import 'package:hse_app/widgets/custom_phone_item.dart';
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

  Future<void> _submitPhoneNumber() async {
    String phoneNumber = _phoneController.text.trim();
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Automatically sign in the user
        await auth.signInWithCredential(credential);
        // Navigate to home or another screen
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Homee()));
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

  Future<void> _submitOtp() async {
    String otp = _otpController.text.trim();
    if (_verificationId == null) return;

    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: otp,
      );
      await auth.signInWithCredential(credential);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Homee()));
    } catch (e) {
      print(e.toString());
    }
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
        image1: 'assets/Menu.png',
        text: 'تسجيل دخول',
        image2: 'assets/HSE  LOGO.png',
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
              const Text(
                'قم بإدخال رقم الجوال!',
                style: TextStyles.styleNormal16,
                textAlign: TextAlign.center,
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
              CustomPhoneItem(phonecontroller: _phoneController),
              const SizedBox(height: 40),
              if (_isOtpSent) ...[
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
                      backgroundColor:
                          Colors.white.withOpacity(1), // Full opacity white
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
              ] else ...[
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
                    child: Text(
                      'تأكيد',
                      style: TextStyles.styleNormalwhite18,
                    ),
                  ),
                ),
              ],
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
                    child: Column(
                      children: [
                        const Text(
                          'إنشاء حساب',
                          style: TextStyle(
                            color: Color.fromRGBO(251, 186, 0, 1),
                            fontSize: 16,
                            fontFamily: 'Tajawal',
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Container(
                          height: 2,
                          width: 85,
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(251, 186, 0, 1),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'ليس لديك حساب؟',
                    style: TextStyle(
                        color: Color.fromRGBO(140, 140, 140, 1),
                        fontSize: 16,
                        fontFamily: 'Tajawal',
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.normal),
                  ),
                ],
              ),
              const SizedBox(height: 30),
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
}
