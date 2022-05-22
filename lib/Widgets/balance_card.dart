import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Theme/light_color.dart';

class BalanceCard extends StatefulWidget {

   BalanceCard({Key? key }) : super(key: key);

  @override
  State<BalanceCard> createState() => _BalanceCardState();
}

class _BalanceCardState extends State<BalanceCard> {
  @override
  Widget build(BuildContext context) {

    CollectionReference users = FirebaseFirestore.instance.collection('users2');
    User? user =  FirebaseAuth.instance.currentUser ;
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(user?.uid).get(),
    builder:
    (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

       if (!snapshot.hasData) {
      return Center(
      child: CircularProgressIndicator(),
      );
     }
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Text("Loading");
      }
    if (snapshot.connectionState == ConnectionState.done) {
      Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
      return Container(

        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(40)),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .27,
              color: LightColor.navyBlue1,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Total Balance',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: LightColor.lightNavyBlue),
                      ),
                      SizedBox(height: 10),
                      Row(

                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('${data == null ? ' ' : data['account']}',
                            style: GoogleFonts.mulish(
                                textStyle: Theme.of(context).textTheme.headline4,
                                fontSize: 35,
                                fontWeight: FontWeight.w800,
                                color: LightColor.yellow2),
                          ),
                          Text(
                            ' EUR',
                            style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.w500,
                                color: LightColor.yellow.withAlpha(200)),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          width: 85,
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              border: Border.all(color: Colors.white, width: 1)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 20,
                              ),
                              SizedBox(width: 5),
                              Text("Top up",
                                  style: TextStyle(color: Colors.white)),
                            ],
                          ))
                    ],
                  ),
                  Positioned(
                    left: -170,
                    top: -170,
                    child: CircleAvatar(
                      radius: 130,
                      backgroundColor: LightColor.lightBlue2,
                    ),
                  ),
                  Positioned(
                    left: -160,
                    top: -190,
                    child: CircleAvatar(
                      radius: 130,
                      backgroundColor: LightColor.lightBlue1,
                    ),
                  ),
                  Positioned(
                    right: -170,
                    bottom: -170,
                    child: CircleAvatar(
                      radius: 130,
                      backgroundColor: LightColor.lightBlue1,
                    ),
                  ),
                  Positioned(
                    right: -160,
                    bottom: -190,
                    child: CircleAvatar(
                      radius: 130,
                      backgroundColor: LightColor.lightBlue2,
                    ),
                  )
                ],
              ),
            )),
      );}
      return Text("loading");

      }
    );
  }
}
