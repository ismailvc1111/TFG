import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import '../theme/light_color.dart';
import '../transfer.dart';
import '../widgets/balance_card.dart';
import '../widgets/bottom_navigation_bar.dart';
import '../widgets/title_text.dart';
import 'HomePage.dart';

class Pages1 extends StatefulWidget {
  @override
  _page1 createState() => _page1();
}
class _page1 extends State<Pages1> {
  var qrsc = "Escaneame";
  User? user =  FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('users2');

  Widget _appBar() {
    return Row(
      children: <Widget>[
        CircleAvatar(
          backgroundImage: NetworkImage(
              "https://i.ibb.co/RQr3dZy/Logotipo-exported-Archivo-Logotipo-Pinchaaqui-2x-1-png.png" ),
        ),
        SizedBox(width: 15),
        TitleText(text: "Hello,"),
        Text(' Ismail,',
            style: GoogleFonts.mulish(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: LightColor.navyBlue2)),
        Expanded(
          child: SizedBox(),
        ),
        IconButton(
          icon: new Icon(Icons.logout_outlined ),
          color: Theme.of(context).iconTheme.color,
          onPressed: () {
             FirebaseAuth.instance.signOut();
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
          },
        )
      ],
    );
  }

  Widget _operationsWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _icon(Icons.transfer_within_a_station, "Transfer" , 0),
        _icon(Icons.phone, "Airtime" ,1),
        _icon(Icons.payment, "Pay Bills",2),
        _icon(Icons.code, "My Qr",3),
      ],
    );
  }

  Widget _icon(IconData icon, String text , int index) {
    var qr = 'qrr';    
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () async {
            if(index == 2){
             await scaQr();

            }
            if (index == 3){
             showDialog(context: context, builder: (context){
               return AlertDialog(
                 title: BarcodeWidget(data:qr, barcode: Barcode.qrCode() ),
               );
             });
          }
            if(index==1) {
              _callNumber();
            }

          },
          child: Container(
            height: 80,
            width: 80,
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Color(0xfff3f3f3),
                      offset: Offset(5, 5),
                      blurRadius: 10)
                ]),
            child: Icon(icon),

          ),
        ),
        Text(text,
            style: GoogleFonts.mulish(
                textStyle: Theme.of(context).textTheme.headline4,
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xff76797e))),
      ],
    );
  }
  Widget _transectionList() {
    final titles = ["List 1", "List 2", "List 3"];
    final subtitles = [
      "Here is list 1 subtitle",
      "Here is list 2 subtitle",
      "Here is list 3 subtitle"
    ];
    return
      Column(
        children: <Widget>[
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount:titles.length,
              itemBuilder: (context,index){

                return  _transection(titles[index], 'hola');
              })
        ],
      );
  }

  Widget _transection(String text, String time) {
    return ListTile(
      leading: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: LightColor.navyBlue1,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Icon(Icons.hd, color: Colors.white),
      ),
      contentPadding: EdgeInsets.symmetric(),
      title: TitleText(
        text: text,
        fontSize: 14,
      ),
      subtitle: Text(time),
      trailing: Container(
          height: 30,
          width: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: LightColor.lightGrey,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Text('-22 MLR',
              style: GoogleFonts.mulish(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: LightColor.navyBlue2))),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:<Widget>[
                      SizedBox(height: 35),
                      _appBar(),
                      SizedBox(
                        height: 40,
                      ),
                      TitleText(text: "My wallet"),
                      SizedBox(
                        height: 20,
                      ),

                      BalanceCard(),
                      SizedBox(
                        height: 50,
                      ),
                      TitleText(
                        text: "Operations",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      _operationsWidget(),
                      SizedBox(
                        height: 40,
                      ),
                      TitleText(
                        text: "Transactions",
                      ),
                      _transectionList(),
                    ],
                  )),
            )));
  }
  Future <void>scaQr()  async{
    try{
     await FlutterBarcodeScanner.scanBarcode('#000000', 'cancel', true, ScanMode.BARCODE).then((value){
        setState(() {
          qrsc=value;

        });
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsPage(id: qrsc,)));
      } );
    }catch(e){
      setState(() {
        qrsc = 'error';
      });
    }
  }

  _callNumber() async{
    const number = '08592119XXXX'; //set the number here
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  }



}
