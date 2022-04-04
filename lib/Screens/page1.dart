import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:barcode_widget/barcode_widget.dart';

import '../theme/light_color.dart';
import '../widgets/balance_card.dart';
import '../widgets/bottom_navigation_bar.dart';
import '../widgets/title_text.dart';
import 'HomePage.dart';

class Pages1 extends StatefulWidget {
  @override
  _page1 createState() => _page1();
}
class _page1 extends State<Pages1> {
  Widget _appBar() {
    return Row(
      children: <Widget>[
        CircleAvatar(
          backgroundImage: NetworkImage(
              "https://cdn-images.motor.es/image/s/235w157h/fotos-coches/2022/mar/21143023/alfa-romeo-giulia-20-gasolina-206kw-280cv-veloce-q4-21143023_1648184046_1.jpg"),
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
          onTap: () {
            if (index == 3){
             showDialog(context: context, builder: (context){
               return AlertDialog(
                 title: BarcodeWidget(data:qr, barcode: Barcode.qrCode() ),
               );
             });
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
    return
      Column(
        children: <Widget>[
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount:2,
              itemBuilder: (context,index){

                return  _transection('home', 'hola');
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
                    children: <Widget>[
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
  }}
