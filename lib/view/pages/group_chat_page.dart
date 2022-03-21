import 'package:animate_do/animate_do.dart';
import 'package:chatapp/functions/show_messages.func.dart';
import 'package:chatapp/providers/messaging_provider.dart';
import 'package:chatapp/services/fireStore_service.dart';
import 'package:chatapp/services/firebase_auth_service.dart';
import 'package:chatapp/widgets/my_messaging_form_field.dart';
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
          appBar: AppBar(title: const Text("Goup chat")),
          body: StreamBuilder<QuerySnapshot>(
            stream: FireStoreService.fireStore
                .collection("group/gapGroups/message")
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
                      return FadeInUp(
                        child:Row(
                          mainAxisAlignment: data[__]["from"]== FirebaseAuthService.auth.currentUser!.uid?MainAxisAlignment.end:MainAxisAlignment.start,
                          children: [
                             showMessages(context, data, data[__].id, __)
                          ],
                        ),
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
          floatingActionButton:
              MyMessagingFormField(messagingController: _messagingController),
        );
      },
    );
  }
}
