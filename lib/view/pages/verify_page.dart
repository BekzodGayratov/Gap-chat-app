// ignore_for_file: must_be_immutable
import 'package:animate_do/animate_do.dart';
import 'package:chatapp/services/fireStore_service.dart';
import 'package:chatapp/services/firebase_auth_service.dart';
import 'package:chatapp/view/pages/sign_up_page.dart';
import 'package:chatapp/view/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class VerifyPage extends StatelessWidget {
  String disName;
  VerifyPage({Key? key, required this.disName}) : super(key: key);

  final _sentCodeController = TextEditingController();
  List? users;
  String uniqueEnc = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.02),
        child: FadeInLeft(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              TextFormField(
                controller: _sentCodeController,
                decoration: InputDecoration(
                    hintText: "Verify code",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0))),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.055,
                child: ElevatedButton(
                  child: const Text("Tasdiqlash"),
                  onPressed: () async {
                    await FirebaseAuthService.verifyOTP(
                            _sentCodeController.text)
                        .then((value) {
                      if (value) {
                        ok(context);
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
            ],
          ),
        ),
      )),
    );
  }

  ok(BuildContext context) async {
    await FirebaseAuthService.auth.currentUser!.updateDisplayName(disName);
    await FirebaseAuthService.auth.currentUser!.updatePhotoURL("https://source.unsplash.com/random");
    await ok2();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (route) => false);
  }

  ok2() async {
    await FireStoreService.fireStore
        .collection("users")
        .doc(FirebaseAuthService.auth.currentUser!.email ??
            FirebaseAuthService.auth.currentUser!.phoneNumber.toString())
        .set({
      "displayName": FirebaseAuthService.auth.currentUser!.displayName.toString(),
      "profilePic": "https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png",
      "eEnc": FieldValue.serverTimestamp(),
    });
  }
}
