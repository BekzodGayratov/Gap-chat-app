import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
  static final fireStore = FirebaseFirestore.instance;
  static DocumentSnapshot<Map<String, dynamic>>? private;

  static readValue({required String collection}) async {
    try {
      await readData();
      await fireStore.collection(collection).doc().get().then((value) {});
      return true;
    } catch (e) {
      print(Exception(e));
      return false;
    }
  }

  static readData() async {
    CollectionReference<Map<String, dynamic>> collection =
        fireStore.collection("private");
    await collection.doc("friends").get().then((value) {
      private = (value);
    });
  }
}
