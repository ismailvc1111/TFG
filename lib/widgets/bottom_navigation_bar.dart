import 'package:flutter/material.dart';

import '../theme/light_color.dart';

class BottomNavigation extends StatelessWidget {
    int index = 0;
   BottomNavigation( this.index, {Key? key, required Null Function(int index) onTap}) : super(key: key);
  BottomNavigationBarItem _icons(IconData icon,){
    return BottomNavigationBarItem(
      icon: Icon(icon,),
      label: ''
    );
  }
  @override
  Widget build(BuildContext context) {
    print(this.index );
    return BottomNavigationBar(
      showUnselectedLabels: false,
      showSelectedLabels: false,
      selectedItemColor:LightColor.navyBlue2,
      unselectedItemColor: LightColor.grey,
      currentIndex: this.index,
        items: [
          _icons(Icons.home,),
          _icons(Icons.chat_bubble_outline),
          _icons(Icons.notifications_none),
          _icons(Icons.person_outline),
        ],

    );
  }
}