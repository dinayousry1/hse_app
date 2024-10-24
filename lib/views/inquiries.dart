import 'dart:io';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hse_app/utiles/text_styles.dart';
import 'package:hse_app/widgets/custom_appbar.dart';
import 'package:hse_app/widgets/custom_footer.dart';
import 'package:hse_app/widgets/custom_textbutton.dart';
import 'package:hse_app/widgets/custom_textformfield.dart';
import 'package:hse_app/widgets/succsessful_send.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Inquiries extends StatefulWidget {
  const Inquiries({super.key});

  @override
  State<Inquiries> createState() => _InquiriesState();
}

class _InquiriesState extends State<Inquiries> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  String? inquiryType;
  List<File>? _images;
  String _selectedCountryCode = '+966';
  bool _isLoading = false;
  CollectionReference inquiries =
      FirebaseFirestore.instance.collection('Inquiries');

  Future<void> _pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile>? images = await picker.pickMultiImage();

    if (images != null && images.isNotEmpty) {
      setState(() {
        // _imageUrls = [];
        _images = images.map((image) => File(image.path)).toList();
      });
    }
  }

  Future<void> addInquiries() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      List<String> imageUrls = [];
      if (_images != null) {
        for (File image in _images!) {
          final storageRef = FirebaseStorage.instance.ref();
          final imageRef =
              storageRef.child('inquiries/${image.path.split('/').last}');
          final uploadTask = await imageRef.putFile(image);
          final url = await uploadTask.ref.getDownloadURL();
          imageUrls.add(url);
        }
      }
      String phoneNumber = _selectedCountryCode + _phoneController.text.trim();
      await inquiries.add({
        "Name": _nameController.text,
        "Phone": phoneNumber,
        "Inquiry Details": _detailsController.text,
        "Inquiry Type": inquiryType,
        "Image URLs": imageUrls,
        'id': FirebaseAuth.instance.currentUser?.uid,
      });

      setState(() {
        _isLoading = false;
      });

      showDialog(
        context: context,
        builder: (context) {
          return const SuccssfulSend();
        },
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

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
        text: 'الإستفسارات',
        image2: 'assets/hse.png',
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        width: 96,
                        height: 96,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          color: Color.fromRGBO(245, 245, 245, 1),
                        ),
                        child: Image.asset(
                          'assets/sad 1.png',
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'الإسم',
                        style: TextStyles.styleNormal16_500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomTextFormField(
                      controller: _nameController,
                      text: 'إكتب الإسم بالكامل',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجي ادخال الأسم بالكامل';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'رقم الجوال',
                        style: TextStyles.styleNormal16_500,
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              color: Color.fromRGBO(245, 245, 245, 1)),
                          child: CountryCodePicker(
                            onChanged: (country) {
                              setState(() {
                                _selectedCountryCode = country.dialCode!;
                              });
                            },
                            initialSelection: 'SA',
                            favorite: const ['+966', 'SA'],
                            showCountryOnly: false,
                            showOnlyCountryWhenClosed: false,
                            alignLeft: false,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'نوع الإستفسار',
                        style: TextStyles.styleNormal16_500,
                      ),
                    ),
                    const SizedBox(height: 10),
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
                            hintText: 'نوع الإستفسار',
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
                              inquiryType = value;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'يرجى اختيار نوع الإستفسار';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 13),
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'تفاصيل الإستفسار',
                        style: TextStyles.styleNormal16_500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 96,
                      child: TextFormField(
                        controller: _detailsController,
                        textDirection: TextDirection.rtl,
                        maxLines: null,
                        minLines: 5,
                        decoration: InputDecoration(
                          hintTextDirection: TextDirection.rtl,
                          hintText: 'إكتب رسالتك',
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'يرجي ادخال تفاصيل الاستفسار';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (_images != null && _images!.isNotEmpty) ...[
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: _images!.map((image) {
                          return SizedBox(
                            width: 100,
                            height: 100,
                            child: Image.file(
                              image,
                              fit: BoxFit.cover,
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 10),
                    ],
                    CustomTextButton(
                      widget: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'أضف صور (إختيارى)',
                            style: TextStyles.styleBoldorange18,
                          ),
                          const SizedBox(width: 5),
                          Image.asset('assets/img.png')
                        ],
                      ),
                      color: const Color(0xFFFFF8E6),
                      onPressed: _pickImages,
                    ),
                    const SizedBox(height: 10),
                    _isLoading
                        ? const CircularProgressIndicator()
                        : CustomTextButton(
                            widget: const Text(
                              'إرسال',
                              style: TextStyles.styleBoldWhite18,
                            ),
                            color: const Color.fromRGBO(255, 186, 0, 1),
                            onPressed: addInquiries,
                          ),
                    const SizedBox(height: 10),
                    const Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            color: Color.fromRGBO(236, 236, 236, 1),
                            endIndent: 10,
                          ),
                        ),
                        Text(
                          'او',
                          style: TextStyles.styleNormal16,
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            color: Color.fromRGBO(236, 236, 236, 1),
                            indent: 10,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    CustomTextButton(
                      widget: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'إتصل بنا',
                            style: TextStyles.styleBoldorange18,
                          ),
                          const SizedBox(width: 5),
                          Image.asset('assets/pho.png')
                        ],
                      ),
                      color: Colors.transparent.withOpacity(0.03),
                      onPressed: () {},
                    ),
                    const SizedBox(height: 60),
                  ],
                ),
              ),
            ),
          ),
          const CustomFooter(num: 60, num2: 24),
        ],
      ),
    );
  }
}
