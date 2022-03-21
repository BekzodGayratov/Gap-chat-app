import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseApi {
  static UploadTask? uploadFile(String destination, File file){
    try {
      final ref = FirebaseStorage.instance.ref(destination).putFile(file);

    } on FirebaseException catch (e) {
      return null;
    }
  }
}
