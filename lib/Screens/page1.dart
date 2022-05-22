import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import '../Theme/light_color.dart';
import 'Transfer/manual.dart';
import 'Transfer/transfer.dart';
import '../Widgets/balance_card.dart';
import '../Widgets/title_text.dart';
import 'Start/HomePage.dart';

class Pages1 extends StatefulWidget {
  @override
  _page1 createState() => _page1();
}
class _page1 extends State<Pages1> {
  var qrsc = "Escaneame";
 late int lenght = 1;
 late String name = "" ;
 User? user =  FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('users2');
  Future<int> getUserNameFromUID() async {
    print('testtt');
    final snapshot = await FirebaseFirestore.instance
        .collection('users2')
        .where('uid', isEqualTo: user?.uid)
        .get();

    setState(() {
      lenght = snapshot.docs.first['Transacciones '].length -1;
    });

    return lenght;

  }
  Future<String> getUserName() async {
    print('testtt');
    final snapshot = await FirebaseFirestore.instance
        .collection('users2')
        .where('uid', isEqualTo: user?.uid)
        .get();

    setState(() {
      name = snapshot.docs.first['name'] ;
    });

    return name;

  }
  @override
  Future<void> setSate() async {
    lenght = await getUserNameFromUID() ;
  }
  @override
  void initState() {
    WidgetsBinding.instance ?.addPostFrameCallback((_) =>  getUserNameFromUID());
    getUserName();
    super.initState();
  }
  
  Widget _appBar() {
    return Row(
      children: <Widget>[
        CircleAvatar(
          backgroundImage: NetworkImage(
            "https://firebasestorage.googleapis.com/v0/b/wallet-76447.appspot.com/o/image_processing20211110-20985-1ovmyxv.png?alt=media&token=a789bcec-3fe1-4fab-8dbe-159c06a22ace",
          ),
        ),
        SizedBox(width: 15),
        TitleText(text: "Hello,"),
        Text('${name}',
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
        _icon(Icons.transfer_within_a_station, "Transfer M" , 0),
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
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(30),
                 ),

                 title: BarcodeWidget(data:qr, barcode: Barcode.qrCode() ),
                   actions: <Widget>[ Center(
                     child: RaisedButton(
               child: Text('Close'),
               onPressed: () => {
               Navigator.of(context).pop()
               },
               color: Colors.blue,
               textColor: Colors.white,
               shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(10)),
               ),
                   ),]
               );
             });
          }
            if(index==1) {
              _callNumber();
            }
            if(index==0) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => manual()));
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
      Container(
        child: Column(
          children: <Widget>[
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount:  lenght,
                itemBuilder: (context,index){

                  return FutureBuilder<DocumentSnapshot>(
                      future: users.doc(user?.uid).get(),
                      builder:
                        (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                           if (snapshot.hasError) {
                                return Text("Something went wrong");
                              }

                  if (snapshot.connectionState == ConnectionState.done) {
                    Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                  List<dynamic>  subtitles = data["Transacciones "];
                  List<dynamic>  subtitles_desc = data["Desc"];
                    List<dynamic>  subtitles_fecha = data["Fecha"];
                   return _transection('${subtitles_desc[index+1]}', '${subtitles_fecha[index+1]}','${subtitles[index+1]}',);

                  }
                  return  Center(
                    child: CircularProgressIndicator(),
                  );
  }

                  );
                })
          ],
        ),
      );
  }

  Widget _transection(String text, String time,String money) {
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
          child: Text(money + " EUR",
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
