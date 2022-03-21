import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/functions/messaging_functions.dart';
import 'package:chatapp/services/fireStore_service.dart';
import 'package:chatapp/services/firebase_auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

showMessages(BuildContext context, String disName,
    List<QueryDocumentSnapshot<Object?>> data, String path, int __) {
  if (data[__]["from"] == FirebaseAuthService.auth.currentUser!.uid ||
      data[__]["from"] == FirebaseAuthService.auth.currentUser!.email) {
    return InkWell(
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            margin: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.01,
                horizontal: MediaQuery.of(context).size.width * 0.02),
            child: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.01,
                  bottom: MediaQuery.of(context).size.height * 0.01,
                  left: MediaQuery.of(context).size.height * 0.01,
                  right: MediaQuery.of(context).size.height * 0.01,
                ),
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
                        child: const Text("Orqaga"),
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
          backgroundImage: CachedNetworkImageProvider(
              FirebaseAuthService.auth.currentUser!.photoURL.toString()),
        ),
        Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              margin: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.01,
                  horizontal: MediaQuery.of(context).size.width * 0.02),
              child: Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.03,
                    bottom: MediaQuery.of(context).size.height * 0.01,
                    left: MediaQuery.of(context).size.height * 0.01,
                    right: MediaQuery.of(context).size.height * 0.01,
                  ),
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
            Positioned(
                top: MediaQuery.of(context).size.height * 0.015,
                left: MediaQuery.of(context).size.width * 0.035,
                child: Text(
                  disName,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                      color: Colors.black87),
                )),
          ],
        ),
      ],
    );
  }
}
