import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:chatapp/services/fireStore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatsScreen extends StatelessWidget {
  ChatsScreen({Key? key}) : super(key: key);
  final CollectionReference privateUsers =
      FirebaseFirestore.instance.collection("users");
  List users = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FireStoreService.getUsers(),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text("ERROR"),
          );
        } else {
          return FireStoreService.allUsers.isEmpty
              ? const Center(
                  child: Text("Hozircha foydalanuvchilar yo'q"),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemBuilder: (conte, index) {
                            return FadeInUp(
                              child: Card(
                                child: InkWell(
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      radius: 25.0,
                                      backgroundImage: profilePic(index),
                                    ),
                                    title: Text(FireStoreService.allUsers
                                        .toList()[index]["displayName"]),
                                    subtitle: const Text(""),
                                  ),
                                  onTap: () {
                                    Navigator.pushNamed(context, '/chatPage',
                                        arguments: [
                                          (snapshot.data!.docs[index].data()
                                                  as Map)["displayName"]
                                              .toString(),
                                          snapshot.data!.docs[index].id
                                              .toString(),
                                          (snapshot.data!.docs[index].data()
                                                  as Map)["profilePic"]
                                              .toString(),
                                        ]);
                                  },
                                ),
                              ),
                            );
                          },
                          itemCount: FireStoreService.allUsers.toList().length),
                    )
                  ],
                );
        }
      },
    );
  }

  profilePic(int index) {
    if (FireStoreService.allUsers.isEmpty) {
      return const AssetImage("");
    } else {
      return NetworkImage(
          FireStoreService.allUsers.toList()[index]["profilePic"]);
    }
  }
}
