import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elementsadmin/Models/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  User user = FirebaseAuth.instance.currentUser;

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
}
