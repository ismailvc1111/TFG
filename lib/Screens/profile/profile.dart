import 'package:flutter/material.dart';
import 'package:login_11/widgets/appbar_widget.dart';
import 'package:login_11/widgets/profile_widget.dart';
class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) =>Scaffold(
    appBar: buildAppBar(context),
    body: ListView(
      padding: EdgeInsets.symmetric(horizontal: 32),
      physics: BouncingScrollPhysics(),
      children: [
       ProfileWidget(imagePath: "", onClicked :
       () async {

       },
       ),

      ],
    ),
  );
}
