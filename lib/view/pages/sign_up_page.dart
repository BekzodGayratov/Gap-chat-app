import 'package:chatapp/core/components/my_textForm_field.dart';
import 'package:chatapp/services/firebase_auth_service.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height *0.02,
            ),
            MyTextFormField(
                controller: _nameController,
                inputDecoration: InputDecoration(
                    hintText: "Abdulloh ibn Muborak",
                    labelText: "First name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)))),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            MyTextFormField(
                controller: _phoneNumberController,
                inputDecoration: InputDecoration(
                    labelText: "Phone number",
                    hintText: "+998916952632",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)))),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.05,
              child: ElevatedButton(
                child: const Text("Sign In"),
                onPressed: () {
                  FirebaseAuthService.loginWithPhone(
                      _phoneNumberController.text);
                  setState(() {});
                  Navigator.pushNamed(context, '/verify',
                      arguments: _nameController.text);
                },
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.05,
              child: ElevatedButton(
                child: const Text("Sign Up With Email"),
                onPressed: () {
                  Navigator.pushNamed(context, '/signUpWithEmail');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
