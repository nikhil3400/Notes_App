import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:firebase_auth/firebase_auth.dart';

class DataBase {
  String title;
  String description;
  DateTime from;
  DateTime to;
  File file;
  CollectionReference colRef;

  DataBase({this.title, this.description, this.from, this.to,this.file});

  Future<void> uploadData() async {

    FirebaseAuth _auth = FirebaseAuth.instance;

    User user = _auth.currentUser;

    colRef = FirebaseFirestore.instance.collection('${user.uid}');

    storage.Reference ref = storage.FirebaseStorage.instance
        .ref()
        .child('files/${Path.basename(file.path)}');

    storage.UploadTask task = ref.putFile(file);

    task.whenComplete(() async {
      await ref.getDownloadURL().then((fileURL) async {
        await colRef.add({
          'url': fileURL,
          'title': this.title,
          'description': this.description,
          'from': this.from,
          'to': this.to
        });
        print('Data Added to firestore');
      });
    });
 }
}
