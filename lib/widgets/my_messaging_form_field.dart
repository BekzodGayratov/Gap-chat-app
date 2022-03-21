import 'package:chatapp/providers/messaging_provider.dart';
import 'package:chatapp/services/fireStore_service.dart';
import 'package:chatapp/services/firebase_auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyMessagingFormField extends StatelessWidget {
  final TextEditingController messagingController;
  const MyMessagingFormField(
      {Key? key, required this.messagingController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width *0.02),
      child: TextFormField(
        controller: messagingController,
        decoration: InputDecoration(
            hintText: "Xabar yozing...",
            suffixIcon: context.watch<MessagingProvider>().isComplete
                ? IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () async {
                      FireStoreService.fireStore
                          .collection("group/gapGroups/message")
                          .doc()
                          .set({
                        "from": FirebaseAuthService.auth.currentUser!.uid.toString(),
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
      ),
    );
  }
}
