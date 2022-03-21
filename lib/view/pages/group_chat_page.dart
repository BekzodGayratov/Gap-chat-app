import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
          appBar: AppBar(
              title: Row(
            children: [
              const CircleAvatar(
                radius: 23.0,
                backgroundImage: CachedNetworkImageProvider(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQqCK8D9UZ8B6eanDhvUNFX0FMQwNrfN-d_PpRwL3LA6r4uH0b79Tq9iC5dsWt-6e1ZhXU&usqp=CAU"),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.02,
              ),
              const Text("Goup chat")
            ],
          )),
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
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemBuilder: (_, __) {
                              return FadeInUp(
                                child: Row(
                                  mainAxisAlignment: data[__]["from"] ==
                                          FirebaseAuthService
                                              .auth.currentUser!.uid
                                      ? MainAxisAlignment.end
                                      : MainAxisAlignment.start,
                                  children: [
                                    showMessages(context, data[__]["disName"], data, data[__].id, __)
                                  ],
                                ),
                              );
                            },
                            itemCount: data.length,
                          ),
                        ),
                      ],
                    ));
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
