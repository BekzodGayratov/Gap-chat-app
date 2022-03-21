import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/functions/messaging_functions.dart';
import 'package:chatapp/services/fireStore_service.dart';
import 'package:chatapp/services/firebase_auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

showMessages(BuildContext context, List<QueryDocumentSnapshot<Object?>> data,
    String path, int __) {
  if (data[__]["from"] == FirebaseAuthService.auth.currentUser!.uid ||
      data[__]["from"] == FirebaseAuthService.auth.currentUser!.email) {
    return InkWell(
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.01,
                horizontal: MediaQuery.of(context).size.width * 0.02),
            child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.01,
                    horizontal: MediaQuery.of(context).size.height * 0.01),
                child: Text(
                  data[__]["message"],
                  style: const TextStyle(
                    fontSize: 17.0,
                    color: Colors.white,
                  ),
                )),
            decoration: BoxDecoration(
              color: color(data[__]["from"]),
              borderRadius: dec(
                data[__]["from"],
              ),
            ),
          ),
          CircleAvatar(
              radius: 18.0,
              backgroundImage: CachedNetworkImageProvider(
                  FirebaseAuthService.auth.currentUser!.photoURL.toString())),
        ],
      ),
      onLongPress: () {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text("Xabar o'chirilsinmi?"),
                  actions: [
                    ElevatedButton(
                        child: Text("Orqaga"),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                    ElevatedButton(
                        child: const Text("O'chirish"),
                        onPressed: () async {
                          await FireStoreService.removeData(data[__].id);
                          Navigator.pop(context);
                        }),
                  ],
                ));
      },
    );
  } else {
    return Row(
      children: [
        CircleAvatar(
            radius: 18.0,
            backgroundImage: CachedNetworkImageProvider(
                FirebaseAuthService.auth.currentUser!.photoURL.toString())),
        Container(
          margin: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.008,
              horizontal: MediaQuery.of(context).size.width * 0.02),
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.01,
                horizontal: MediaQuery.of(context).size.height * 0.01),
            child: Text(
              data[__]["message"],
              style: const TextStyle(fontSize: 17.0, color: Colors.white),
              overflow: TextOverflow.visible,
              maxLines: 10,
            ),
          ),
          decoration: BoxDecoration(
            color: color(data[__]["from"]),
            borderRadius: dec(
              data[__]["from"],
            ),
          ),
        ),
      ],
    );
  }
}
