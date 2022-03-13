import 'package:chatapp/core/components/my_textForm_field.dart';
import 'package:chatapp/services/fireStore_service.dart';
import 'package:chatapp/services/firebase_auth_service.dart';
import 'package:chatapp/view/pages/sign_up_page.dart';
import 'package:chatapp/view/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SignUpWithEmailPage extends StatelessWidget {
  SignUpWithEmailPage({Key? key}) : super(key: key);

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
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
                  controller: _emailController,
                  inputDecoration: InputDecoration(
                      labelText: "Email",
                      hintText: "example@gmail.com",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0)))),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              MyTextFormField(
                  controller: _passwordController,
                  inputDecoration: InputDecoration(
                      hintText: "Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0)))),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.05,
                child: ElevatedButton(
                  child: const Text("Sign Up"),
                  onPressed: () async {
                    await FirebaseAuthService.createEmailAndPassword(
                            _emailController.text, _passwordController.text)
                        .then((value) {
                      if (value) {
                        ok(context);
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()),
                            (route) => false);
                      } else {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpPage()),
                            (route) => false);
                      }
                    });
                  },
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
            ],
          ),
        ),
      ),
    );
  }

  ok(BuildContext context) async {
    await ok2();
    await FirebaseAuthService.auth.currentUser!
        .updateDisplayName(_nameController.text);
  }

  ok2() async {
    await FireStoreService.fireStore
        .collection("users")
        .doc(FirebaseAuthService.auth.currentUser!.email ??
            FirebaseAuthService.auth.currentUser!.phoneNumber.toString())
        .set({
      "displayName": FirebaseAuthService.auth.currentUser!.email ??
          FirebaseAuthService.auth.currentUser!.phoneNumber,
      "profilePic":
          "https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg",
      "eEnc": FieldValue.serverTimestamp(),
    });
  }
}