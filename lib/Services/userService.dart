import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elementsadmin/Models/UserModel.dart';
import 'package:elementsadmin/Provider/currentuser.dart';
import 'package:elementsadmin/Services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:html';

import 'package:flutter/material.dart';

class UserService {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  User user = FirebaseAuth.instance.currentUser;
  FirebaseStorage storage = FirebaseStorage.instance;

  addUserToCollection({UserModel user}) {
    this.users.add(user.toMap());
  }

  getUser({User user}) async {
    await users.doc(user.uid).get().then((DocumentSnapshot doc) {
      if (doc.exists) {
        return UserModel.get(doc);
      }
      // return UserModel.get(doc);
    });
  }

  Future getUsersList() async {
    List itemList = [];

    try {
      await users.get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          itemList.add(element.data);
        });
      });
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> updateUsers(
      DocumentSnapshot doc, String firstName, String lastName, String email) {
    var user = FirebaseAuth.instance.currentUser;
    return users
        .doc(user.uid)
        .update({'firstName': firstName, 'lastName': lastName, 'email': email})
        .then((value) => print("User ${doc.id} Updated"))
        .catchError((error) => print("Failed to update lesson: $error"));
  }

  //delete
  Future<void> deleteUsers(DocumentSnapshot doc) {
    return users
        .doc(doc.id)
        .delete()
        .then((value) => print("User ${users.id} is Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  Future<Uri> downloadUrl(String photoUrl) {
    return fb
        .storage()
        .refFromURL('gs://final-elements.appspot.com')
        .child(photoUrl)
        .getDownloadURL();
  }

  void uploadImage({@required Function(File file) onSelected}) {
    InputElement uploadInput = FileUploadInputElement()..accept = 'image/*';
    uploadInput.click();

    uploadInput.onChange.listen((event) {
      final file = uploadInput.files.first;
      final reader = FileReader();
      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen((event) {
        onSelected(file);
        print('done');
      });
    });
  }

  Stream<CurrentUser> userStream() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc('testupload')
        .snapshots()
        .map((doc) => CurrentUser.fromDoc(doc));
  }

  Future<void> uploadToStorage(CurrentUser user) async {
    final dateTime = DateTime.now();
    final userId = user.id;
    final path = '$userId/$dateTime';

    uploadImage(
      onSelected: (file) {
        fb
            .storage()
            .refFromURL('gs://final-elements.appspot.com')
            .child(path)
            .put(file)
            .future
            .then((fb.UploadTaskSnapshot item) async {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.id)
              .update({'photo_url': item.ref.toString()});
          print(item.ref);
        });
      },
    );
  }
}
