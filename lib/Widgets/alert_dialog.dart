import 'package:flutter/material.dart';
class alert_dialog extends StatefulWidget {
  const alert_dialog({Key? key}) : super(key: key);

  @override
  State<alert_dialog> createState() => _alert_dialogState();
}

class _alert_dialogState extends State<alert_dialog> {
  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      title: Text('Scan Me'),
      content:  Text('This is a body from Alert Dialog'),
      actions: <Widget>[
        FlatButton(onPressed: (){}, child: Text("Yes")),
        FlatButton(onPressed: (){}, child: Text("No")),
       ],

    );
  }
}
