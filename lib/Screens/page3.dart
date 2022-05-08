import 'package:flutter/material.dart';
class page4 extends StatefulWidget {
  const page4({Key? key}) : super(key: key);

  @override
  State<page4> createState() => _page4State();
}

class _page4State extends State<page4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        
        child: Center(child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          Icon(Icons.notifications_off_outlined, size: 40),
          Text('No notification')
        ])),
      ),
    );
  }
}
