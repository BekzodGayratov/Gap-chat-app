import 'dart:math';

import 'package:chatapp/services/firebase_auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FireStoreService {
  List<Map<String, dynamic>> usersProfilePic = [];
  static final fireStore = FirebaseFirestore.instance;
  static DocumentSnapshot<Map<String, dynamic>>? private;
  static Set allUsers = {};

  static readValue({required String collection}) async {
    try {
      await fireStore.collection(collection).doc().get().then((value) {});
      return true;
    } catch (e) {
      return false;
    }
  }

  static removeField(int indexAt, String path, String id) async {
    await fireStore.doc("users/$path/message/$id").delete();
  }

  static removeData(String id) async {
    await fireStore.doc("group/gapGroups/message/$id").delete();
  }

  static getUsers() async {
    await fireStore.collection("users").get().then((QuerySnapshot value) {
      allUsers.clear();
      for (var element in value.docs) {
        if (element.id != FirebaseAuthService.auth.currentUser!.uid) {
          allUsers.add((element.data() as Map));
        }
      }
    });
    return allUsers;
  }
}
