import 'package:flutter/material.dart';


class scanner extends StatefulWidget {
  const scanner({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<scanner> createState() => _scannerState();
}

class _scannerState extends State<scanner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(onPressed: (){}, child:
            Text('Creating qr code ')),
            ElevatedButton(onPressed: (){}, child:
            Text('Creating qr code '))
          ],
        ),
      ),
    );
  }
}
