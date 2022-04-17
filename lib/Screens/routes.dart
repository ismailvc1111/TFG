import 'package:flutter/material.dart';
import 'package:login_11/Screens/page1.dart';
import 'package:login_11/Screens/page3.dart';
import 'package:login_11/Screens/profile/profile.dart';

import 'chatbot/chatbot.dart';

class routes extends StatelessWidget {
  final int index ;
  const routes({Key? key, required this.index }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> mylist =[
      Pages1(),
      Chat(),
      page4(),
      EditProfilePage()
    ];

    return mylist[index];
  }
}
