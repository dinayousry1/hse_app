import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hse_app/utils/text_styles.dart';
import 'package:hse_app/widgets/custom_appbar.dart';
import 'package:hse_app/widgets/custom_footer.dart';
import 'package:hse_app/widgets/custom_phone_item.dart';
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
  File? _image;
  String? _imageUrl;
  CollectionReference Inquiries =
      FirebaseFirestore.instance.collection('Inquiries');

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  Future<void> addInquiries() async {
    if (_formKey.currentState!.validate()) {
      String? imageUrl;
      if (_image != null) {
        final storageRef = FirebaseStorage.instance.ref();
        final imageRef =
            storageRef.child('inquiries/${_image!.path.split('/').last}');
        final uploadTask = await imageRef.putFile(_image!);
        imageUrl = await uploadTask.ref.getDownloadURL();
      }

      DocumentReference response = await Inquiries.add({
        "Name": _nameController.text,
        "Phone": _phoneController.text,
        "Inquiry Details": _detailsController.text,
        "Inquiry Type": inquiryType,
        "Image URL": imageUrl,
      });

      showDialog(
        context: context,
        builder: (context) {
          return SuccssfulSend();
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
        image1: 'assets/Menu.png',
        text: 'الإستفسارات',
        image2: 'assets/HSE  LOGO.png',
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
                    CustomPhoneItem(
                      phonecontroller: _phoneController,
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
                    if (_image != null) ...[
                      Image.file(
                        _image!,
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 10),
                    ],
                    CustomTextButton(
                      widget: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'أضف صورة (إختيارى)',
                            style: TextStyles.styleBoldorange18,
                          ),
                          const SizedBox(width: 5),
                          Image.asset('assets/img.png')
                        ],
                      ),
                      color: const Color(0xFFFFF8E6),
                      onPressed: _pickImage,
                    ),
                    const SizedBox(height: 10),
                    CustomTextButton(
                      widget: const Text(
                        'إرسال',
                        style: TextStyles.styleBoldWhite18,
                      ),
                      color: const Color.fromRGBO(255, 186, 0, 1),
                      onPressed: () {
                        addInquiries();
                      },
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
