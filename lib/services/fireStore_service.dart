import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
  List<Map<String, dynamic>> usersProfilePic = [];
  static final fireStore = FirebaseFirestore.instance;
  static DocumentSnapshot<Map<String, dynamic>>? private;

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
    await fireStore.doc("group/$id").delete();
  }
}
