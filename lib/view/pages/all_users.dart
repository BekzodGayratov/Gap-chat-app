import 'package:cached_network_image/cached_network_image.dart';
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
                          child: const ListTile(
                            leading: CircleAvatar(
                              radius: 25.0,
                              backgroundImage: CachedNetworkImageProvider(
                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQqCK8D9UZ8B6eanDhvUNFX0FMQwNrfN-d_PpRwL3LA6r4uH0b79Tq9iC5dsWt-6e1ZhXU&usqp=CAU"),
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
