import 'package:chatapp/functions/messaging_functions.dart';
import 'package:chatapp/services/fireStore_service.dart';
import 'package:chatapp/services/firebase_auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

showMessages(
    BuildContext context, List<QueryDocumentSnapshot<Object?>> data, String path ,int __) {
  if (data[__]["from"] == FirebaseAuthService.auth.currentUser!.email ||
      data[__]["from"] == FirebaseAuthService.auth.currentUser!.phoneNumber) {
    return Row(
      children: [
        InkWell(
          child: Container(
            margin: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.01,
                horizontal: MediaQuery.of(context).size.width * 0.02),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.01,
                  horizontal: MediaQuery.of(context).size.height * 0.01),
              child: Text(
                data[__]["message"],
                style: const TextStyle(fontSize: 17.0, color: Colors.white),
                maxLines: 10,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            decoration: BoxDecoration(
              color: color(data[__]["from"]),
              borderRadius: dec(
                data[__]["from"],
              ),
            ),
          ),
          splashColor: Colors.transparent,
          onLongPress: () async {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: const Text("Xabar o'chirilsinmi?"),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Orqaga")),
                        ElevatedButton(
                            onPressed: () async {
                              await FireStoreService.removeField(__, path, data[__].id);
                              Navigator.pop(context);
                            },
                            child: const Text("O'chirish"))
                      ],
                    ));
          },
        ),
        CircleAvatar(
          backgroundColor: Colors.red,
        ),
      ],
    );
  } else {
    return Row(
      children: [
        CircleAvatar(backgroundColor: Colors.red, radius: 18.0),
        InkWell(
          child: Container(
            margin: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.008,
                horizontal: MediaQuery.of(context).size.width * 0.02),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.01,
                  horizontal: MediaQuery.of(context).size.height * 0.01),
              child: SizedBox(
                  child: Text(
                data[__]["message"],
                style: const TextStyle(fontSize: 17.0, color: Colors.white),
                overflow: TextOverflow.visible,
                maxLines: 10,
              )),
            ),
            decoration: BoxDecoration(
              color: color(data[__]["from"]),
              borderRadius: dec(
                data[__]["from"],
              ),
            ),
          ),
          splashColor: Colors.transparent,
          onLongPress: () async {},
        ),
      ],
    );
  }
}
