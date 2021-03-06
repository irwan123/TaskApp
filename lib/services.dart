import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class MyFirebaseStorage {
  static UploadTask? uploadFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);
      return ref.putFile(file);
    } on FirebaseException catch (e) {
      // ignore: avoid_print
      print('Error!');
      // ignore: avoid_print
      print(e);
      return null;
    }
  }
}
