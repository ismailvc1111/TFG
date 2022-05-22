import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_11/Screens/routes.dart';

import '../Theme/light_color.dart';
import '../Widgets/balance_card.dart';
import '../Widgets/bottom_navigation_bar.dart';
import '../Widgets/title_text.dart';
import 'Start/HomePage.dart';

class Pages_2 extends StatefulWidget {

  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Pages_2> {
  BottomNavigationBarItem _icons(IconData icon,){
    return BottomNavigationBarItem(
        icon: Icon(icon,),
        label: ''
    );
  }
  int inde_page =0 ;

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: false,
          showSelectedLabels: false,
          selectedItemColor:LightColor.navyBlue2,
          unselectedItemColor: LightColor.grey,
          currentIndex: inde_page,
          items: [
            _icons(Icons.home,),
            _icons(Icons.chat_bubble_outline),
            _icons(Icons.notifications_none),
            _icons(Icons.person_outline),
          ],
        onTap: (int i ){
            setState(() {
             print( inde_page);
            });
            inde_page = i;
        },
        ),

        body: routes(index: inde_page));
  }
}