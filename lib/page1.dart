import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:login_11/HomePage.dart';
class page1 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Signed In as'),
            SizedBox(height: 8),
            Text(user.uid!),
            Text(user.email!),
            SizedBox(height: 40),
            ElevatedButton.icon(onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));

            }, icon: Icon(Icons.arrow_back),
                label: Text('Sign Out'))
          ],
        ),
      ),
    );
  }
}
