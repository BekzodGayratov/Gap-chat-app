import 'package:animate_do/animate_do.dart';
import 'package:chatapp/functions/show_messages.func.dart';
import 'package:chatapp/providers/messaging_provider.dart';
import 'package:chatapp/services/fireStore_service.dart';
import 'package:chatapp/services/firebase_auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroupChatPage extends StatelessWidget {
  GroupChatPage({Key? key}) : super(key: key);

  final _messagingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MessagingProvider(),
      builder: (context, child) {
        return Scaffold(
          body: StreamBuilder<QuerySnapshot>(
            stream: FireStoreService.fireStore
                .collection("group")
                .orderBy("created_at")
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text("ERROR"),
                );
              } else {
                var data = snapshot.data!.docs;
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.01),
                  child: ListView.builder(
                    itemBuilder: (_, __) {
                      return Row(
                        mainAxisAlignment: data[__]["from"] ==
                                FirebaseAuthService
                                    .auth.currentUser!.phoneNumber
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                        ],
                      );
                    },
                    itemCount: data.length,
                  ),
                );
              }
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.02),
            child: TextFormField(
              controller: _messagingController,
              decoration: InputDecoration(
                  hintText: "Xabar yozing...",
                  suffixIcon: context.watch<MessagingProvider>().isComplete
                      ? IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: () async {
                            FireStoreService.fireStore
                                .collection("group")
                                .doc()
                                .set({
                              "from": FirebaseAuthService
                                      .auth.currentUser!.phoneNumber ??
                                  FirebaseAuthService
                                      .auth.currentUser!.phoneNumber,
                              "message": _messagingController.text,
                              "created_at": FieldValue.serverTimestamp(),
                            });
                            _messagingController.clear();
                          },
                        )
                      : null),
              onChanged: (v) {
                context.read<MessagingProvider>().showSendButton(v.toString());
              },
            ),
          ),
        );
      },
    );
  }
}
