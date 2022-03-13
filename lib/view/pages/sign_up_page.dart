import 'package:animate_do/animate_do.dart';
import 'package:chatapp/core/components/my_textForm_field.dart';
import 'package:chatapp/functions/change_number_func.dart';
import 'package:chatapp/providers/numbers_provider.dart';
import 'package:chatapp/services/firebase_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String dropValue = "+998";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
          create: (context) => PhoneNumbersProvider(),
          builder: (context, child) {
            return SafeArea(
              child: FadeInLeft(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.02),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                hintText: "Abdulloh ibn Muborak",
                                labelText: "Ismingiz",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                              validator: (v) {
                                if (v!.isEmpty) {
                                  return "To'ldirish majburiy";
                                }
                              },
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            TextFormField(
                              controller: _phoneNumberController,
                              decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: EdgeInsets.all(
                                      MediaQuery.of(context).size.height *
                                          0.01),
                                  child: DropdownButtonHideUnderline(
                                      child: numbersChanger(context)),
                                ),
                                labelText: "Telefon raqam",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                              validator: (v) {
                                if (v!.isEmpty) {
                                  return "To'ldirish majburiy";
                                } else if (v.length > 9) {
                                  return "Iltimos yaroqliy raqam kiriting";
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: ElevatedButton(
                          child: const Text("Ro'yhatdan o'tish"),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await FirebaseAuthService.loginWithPhone(
                                  Provider.of<PhoneNumbersProvider>(context,
                                              listen: false)
                                          .dropValue +
                                      _phoneNumberController.text);
                              setState(() {});
                              Navigator.pushNamed(context, '/verify',
                                  arguments: _nameController.text);
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: ElevatedButton(
                          child: const Text("Account yaratish"),
                          onPressed: () {
                            Navigator.pushNamed(context, '/signUpWithEmail');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
