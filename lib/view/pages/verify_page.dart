// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:chatapp/services/fireStore_service.dart';
import 'package:chatapp/services/firebase_auth_service.dart';
import 'package:chatapp/view/pages/sign_up_page.dart';
import 'package:chatapp/view/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
          child: Column(
        children: [
          TextFormField(
            controller: _sentCodeController,
            decoration: InputDecoration(
                hintText: "Verify code",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0))),
          ),
          ElevatedButton(
            child: const Text("Verify"),
            onPressed: () async {
              FirebaseAuthService.verifyOTP(_sentCodeController.text)
                  .then((value) {
                if (value) {
                  ok(context);
                } else {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                      (route) => false);
                }
              });
            },
          )
        ],
      )),
    );
  }

  ok(BuildContext context) async {
    await ok2();
    await FirebaseAuthService.auth.currentUser!.updateDisplayName(disName);
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
      "displayName":
          FirebaseAuthService.auth.currentUser!.email?? FirebaseAuthService.auth.currentUser!.phoneNumber,
      "profilePic":
          "https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg",
      "eEnc": FieldValue.serverTimestamp(),
    });
  }

  
}
