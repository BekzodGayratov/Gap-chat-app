import 'package:animate_do/animate_do.dart';
import 'package:chatapp/functions/show_messages.func.dart';
import 'package:chatapp/providers/messaging_provider.dart';
import 'package:chatapp/services/fireStore_service.dart';
import 'package:chatapp/services/firebase_auth_service.dart';
import 'package:chatapp/widgets/my_messaging_form_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPageWidget extends StatelessWidget {
  final String indexAt;
  final String path;
  ChatPageWidget({Key? key, required this.indexAt, required this.path})
      : super(key: key);
  final _messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MessagingProvider(),
      builder: (context, child) {
        return Scaffold(
          body: StreamBuilder<QuerySnapshot>(
            stream: FireStoreService.fireStore
                .doc("users/$path")
                .collection("message")
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
                                    .auth.currentUser!.displayName
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          FadeInUp(
                            child: showMessages(context, data, path, __),
                          )
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
            child: MyMessagingFormField(
                messagingController: _messageController, path: path),
          ),
        );
      },
    );
  }
}
