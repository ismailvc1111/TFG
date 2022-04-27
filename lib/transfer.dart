

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_11/widgets/title_text.dart';

class DetailsPage extends StatefulWidget {
  final String id ;
  DetailsPage({required this.id });


  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  var selectedCard = 'WEIGHT';
  late TextEditingController _controller;
   int total = 0;
  final int foodPrice=2;
  @override
  void initState() {
    super.initState();
    _controller = new TextEditingController(text: widget.id);
  }
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff15294a),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text('Details',
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 18.0,
                  color: Colors.white)),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.more_horiz),
              onPressed: () {},
              color: Colors.white,
            )
          ],
        ),
        body: ListView(children: [
          Stack(children: [
            Container(
                height: MediaQuery.of(context).size.height - 82.0,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent),
            Positioned(
                top: 75.0,
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(45.0),
                          topRight: Radius.circular(45.0),
                        ),
                        color: Colors.white),
                    height: MediaQuery.of(context).size.height - 100.0,
                    width: MediaQuery.of(context).size.width)),

            Positioned(
                top: 250.0,
                left: 25.0,
                right: 25.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Text('Payment',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(height: 20.0),
                    TextField(decoration: InputDecoration(
                      labelText: "Id",
                      prefixText: "Id -",

                    ),
                   controller: _controller ),
                    SizedBox(height: 40.0),
                    TextField(decoration: InputDecoration(
                      labelText: "Id",
                      prefixText: "Id -",

                    )),
                    SizedBox(height: 20.0),
                    //Ttextfield
                    SizedBox(height: 20.0),
                    Padding(
                      padding: EdgeInsets.only(bottom:5.0),
                      child: GestureDetector(
                        onTap: (){
                          print('tester');
                          Read();
                          Transfer();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0), bottomLeft: Radius.circular(25.0), bottomRight: Radius.circular(25.0)),
                              color: Colors.black
                          ),
                          height: 50.0,
                          child: Center(
                                child: Text(
                                    'Pay',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Montserrat',
                                        fontSize: 20
                                    )

                              ),
                            ),
                          ),
                      ),

                    )
                  ],
                ))
          ])
        ]));
  }

  Widget _buildInfoCard(String cardTitle, String info, String unit) {
    return InkWell(
        onTap: () {
          selectCard(cardTitle);
        },
        child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeIn,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: cardTitle == selectedCard ? Color(0xFF7A9BEE) : Colors.white,
              border: Border.all(
                  color: cardTitle == selectedCard ?
                  Colors.transparent :
                  Colors.grey.withOpacity(0.3),
                  style: BorderStyle.solid,
                  width: 0.75
              ),

            ),
            height: 100.0,
            width: 100.0,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 15.0),
                    child: Text(cardTitle,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 12.0,
                          color:
                          cardTitle == selectedCard ? Colors.white : Colors.grey.withOpacity(0.7),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, bottom: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(info,
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 14.0,
                                color: cardTitle == selectedCard
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.bold)),
                        Text(unit,
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 12.0,
                              color: cardTitle == selectedCard
                                  ? Colors.white
                                  : Colors.black,
                            ))
                      ],
                    ),
                  )
                ]
            )
        )
    );
  }
//--------------------------------------------------------transferenciade datos --------------------------------------------------------------------------------------------
  Future <void>Read() async{


  }





  //=---------------------------------------------Receptor---------------------------------------------
  Future <void>Transfer()  async{
    User? user = await FirebaseAuth.instance.currentUser;
    CollectionReference users = FirebaseFirestore.instance.collection('users2');
    print(user?.uid);
    DocumentReference  document= FirebaseFirestore.instance
        .collection('users2')
        .doc('1aI6vk825QRIkaJMhOz48IrhxHz2');
    document.get().then(( value) {

      print(value['account']);
      total= value['account'];
      //-----------------------------------------------------------------
      users
          .doc('1aI6vk825QRIkaJMhOz48IrhxHz2')
          .update({'account': total + 10})
          .then((value) => print("User Updated"))
          .catchError((error) => print("Failed to update user: $error"));

    });
    return print('Succes');


  }
  selectCard(cardTitle) {
    setState(() {
      selectedCard = cardTitle;
    });
  }
}