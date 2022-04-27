import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class update  {
  Future<bool> udpata(String uid , String Pass , String Name) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = await FirebaseAuth.instance.currentUser;
    bool _auth = false;
    CollectionReference users = FirebaseFirestore.instance.collection('users2');

    Future<void> updateUser() {
      return users
          .doc(uid)
          .update({'name': 'Stokes and Sons','email': 'Stokes and Sons','city': 'Stokes and Sons','image': 'Stokes and Sons'})
          .then((value) => print("User Updated"))
          .catchError((error) => print("Failed to update user: $error"));
    }

     return true;

  }}





