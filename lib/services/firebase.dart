import 'dart:core';
import 'dart:core';
import 'dart:js';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Screens/page1.dart';

class firebase  {
  Future<bool> signUp(String Email , String Pass , String Name) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = await FirebaseAuth.instance.currentUser;
    bool _auth = false;
    try {
      await auth.createUserWithEmailAndPassword(email: Email, password: Pass).then((value) =>
      {
        FirebaseFirestore.instance.collection('users2').doc(value.user?.uid).set(
            {
              'name': Name,
              'Email':Email,
              'account': 0,

            }

        ),
        _auth =true,
        print('Succes')

      });

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }

    return _auth;

  }





}