import 'package:chatapp/services/fireStore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GroupChat extends StatelessWidget {
  const GroupChat({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: FutureBuilder(
            future: FireStoreService.fireStore.collection("group").get(),
            builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              } else if (snapshot.hasError) {
                return const Text("Error");
              } else {
                var data = snapshot.data!.docs;
                return ListView.builder(
                    itemBuilder: (_, __) {
                      return Card(
                        child: InkWell(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: 25.0,
                            ),
                            title: Text("Group chat"),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, '/groupChat');
                          },
                        ),
                      );
                    },
                    itemCount: data.length);
              }
            },
          ),
        )
      ],
    );
  }
}
