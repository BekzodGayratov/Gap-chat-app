import 'package:animate_do/animate_do.dart';
import 'package:chatapp/services/fireStore_service.dart';
import 'package:chatapp/services/firebase_auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatsScreen extends StatelessWidget {
  ChatsScreen({Key? key}) : super(key: key);
  final CollectionReference privateUsers =
      FirebaseFirestore.instance.collection("users");

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: privateUsers.get(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text("ERROR"),
          );
        } else {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemBuilder: (conte, index) {
                      QuerySnapshot<Map<String, dynamic>> data;
                      FireStoreService.fireStore
                          .collection(
                              "users/${snapshot.data!.docs[index].id}/message")
                          .get()
                          .then((value) {
                        data = value;
                      });
                      return FadeInUp(
                        child: Card(
                          child: InkWell(
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    (snapshot.data!.docs[index].data()
                                        as Map)["profilePic"]),
                                radius: 25.0,
                              ),
                              title: Text((snapshot.data!.docs[index].data()
                                      as Map)["displayName"]
                                  .toString()),
                              subtitle: Text(""),
                            ),
                            onTap: () {
                              print(snapshot.data!.docs[index].id);
                              Navigator.pushNamed(context, '/chatPage',
                                  arguments: [
                                    (snapshot.data!.docs[index].data()
                                            as Map)["displayName"]
                                        .toString(),
                                    snapshot.data!.docs[index].id.toString(),
                                    (snapshot.data!.docs[index].data()
                                            as Map)["profilePic"]
                                        .toString(),
                                  ]);
                            },
                          ),
                        ),
                      );
                    },
                    itemCount: snapshot.data!.docs.length),
              )
            ],
          );
        }
      },
    );
  }
}
