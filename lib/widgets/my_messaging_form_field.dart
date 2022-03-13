import 'package:chatapp/providers/messaging_provider.dart';
import 'package:chatapp/services/fireStore_service.dart';
import 'package:chatapp/services/firebase_auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyMessagingFormField extends StatelessWidget {
  final TextEditingController messagingController;
  final String path;
  const MyMessagingFormField(
      {Key? key, required this.messagingController,required this.path})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: messagingController,
      decoration: InputDecoration(
          hintText: "Xabar yozing...",
          suffixIcon: context.watch<MessagingProvider>().isComplete
              ? IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () async {
                    FireStoreService.fireStore
                        .doc("users/$path")
                        .collection("message")
                        .doc()
                        .set({
                      "from":
                          FirebaseAuthService.auth.currentUser!.phoneNumber ??
                              FirebaseAuthService.auth.currentUser!.phoneNumber,
                      "message": messagingController.text,
                      "created_at": FieldValue.serverTimestamp(),
                    });
                    messagingController.clear();
                  },
                )
              : null),
      onChanged: (v) {
        context.read<MessagingProvider>().showSendButton(v.toString());
      },
    );
  }
}
