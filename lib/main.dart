import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Screens/HomePage.dart';
import 'Screens/page1.dart';
import 'Screens/pages2.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    home: MainPage(),
  ));
}
class MainPage extends StatelessWidget {
  @override

  Widget build( BuildContext context) => Scaffold(
    body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context ,snapshot){
        if(snapshot.hasData){
          return HomePage();
        }else{
          return Pages_2();
        }
      }
    ),
  );
}

