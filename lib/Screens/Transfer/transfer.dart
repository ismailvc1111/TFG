import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:login_11/Widgets/title_text.dart';

import '../page1.dart';
import '../pages2.dart';
class DetailsPage extends StatefulWidget {
  final String id ;
  DetailsPage({required this.id });
  @override
  _DetailsPageState createState() => _DetailsPageState();
}
class _DetailsPageState extends State<DetailsPage> {
  //-----------------------------------------
  FirebaseAuth auth = FirebaseAuth.instance;
  RegExp digitValidator  = RegExp("[0-9]+");
  bool isANumber = true;
  var selectedCard = 'WEIGHT';
  late TextEditingController _controllerDestino;
  late TextEditingController _controllereuro;
  late TextEditingController _controllerDesc;
   int totalDestino = 0;
   int totalOrigen =0;
  final int foodPrice=2;
  ////setsTransaccions
  List<dynamic> setsDestino = [];
  List<dynamic> setsOrigen = [];
  //Descriptionoftransaction
  List<dynamic> setsDestino_Desc = [];
  List<dynamic> setsOrigen_Desc = [];
  //Fechas
  List<dynamic> setsDestino_Fechas = [];
  List<dynamic> setsOrigen_Fechas = [];
  User? user =  FirebaseAuth.instance.currentUser;

  //---------------------------------------
  @override
  void initState() {
    super.initState();
    _controllerDestino = new TextEditingController(text: widget.id);
    _controllereuro = new TextEditingController();
    _controllerDesc = new TextEditingController();
  }void setValidator(valid) {
    setState(() {
      isANumber = valid;
    });
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
                   controller: _controllerDestino ),
                    SizedBox(height: 40.0),
                    TextField(decoration: InputDecoration(
                      labelText: "Description",
                      prefixText: "",

                    ),
                        controller: _controllerDesc ) ,
                    SizedBox(height: 40.0),
                    TextField(onChanged: (inputValue){
                      if(inputValue.isEmpty || digitValidator.hasMatch(inputValue)){
                        setValidator(true);
                      } else{
                        setValidator(false);
                      }
                    },
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                      errorText: isANumber ? null : "Please enter a Mount",
                      labelText: "Mount",
                      prefixText: "Eur-",
                    ),
                   controller: _controllereuro),

                    SizedBox(height: 20.0),
                    //Ttextfield
                    SizedBox(height: 20.0),
                    Padding(
                      padding: EdgeInsets.only(bottom:5.0),
                      child: GestureDetector(
                        onTap: (){

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

  //=---------------------------------------------Receptor---------------------------------------------
  Future <void>Transfer()  async{

    CollectionReference users = FirebaseFirestore.instance.collection('users2');
    print(user?.uid);
    DocumentReference  document= FirebaseFirestore.instance
        .collection('users2')
        .doc('1aI6vk825QRIkaJMhOz48IrhxHz2');
    DocumentReference  documentOrigin= FirebaseFirestore.instance
        .collection('users2')
        .doc('${user?.uid}');
   //----------------------Origin----------------------------------------
    if(await boolCheckDestino()==true){
           ListTRansferD();
     await ListTRansferO();
           ListDescD();
     await ListDescO();
     await ListFechaO();
     await ListFechaD();
    documentOrigin.get().then(( value) {
      totalOrigen= value['account'];
      users
          .doc('${user?.uid}')
          .update({'account':totalOrigen - int. parse(_controllereuro.text.trim()), "Transacciones ": setsOrigen ,"Desc": setsOrigen_Desc,"Fecha": setsOrigen_Fechas})

          .then((value) => {

      })
          .catchError((error) => print("Failed to update user: $error"));

    });
    //-----------------Destino-------------------------------------------
    document.get().then((value) {
      totalDestino= value['account'];
      users
          .doc('1aI6vk825QRIkaJMhOz48IrhxHz2')
          .update({'account':totalDestino + int.parse(_controllereuro.text.trim()), "Transacciones ": setsDestino,"Desc": setsDestino_Desc,"Fecha":setsDestino_Fechas})
          .then((value) => checkConnection(2))
          .catchError((error) => print("Failed to update user: $error"));

    });
    }else{
      checkConnection(2);
    }
    return print('Succes');
  }

  Future<List> ListTRansferD() async {

    final snapshot = await FirebaseFirestore.instance
        .collection('users2')
        .where('uid', isEqualTo: '1aI6vk825QRIkaJMhOz48IrhxHz2')
        .get();
    setsDestino= snapshot.docs.first['Transacciones '];

    setsDestino.add(int.parse(_controllereuro.text.trim()));

    return setsDestino;
  }
  Future<List> ListDescD() async {

    final snapshot = await FirebaseFirestore.instance
        .collection('users2')
        .where('uid', isEqualTo: '1aI6vk825QRIkaJMhOz48IrhxHz2')
        .get();
    setsDestino_Desc= snapshot.docs.first['Desc'];
    setsDestino_Desc.add(_controllerDesc.text.trim());

    return setsDestino_Desc;
  }
  Future<List> ListDescO() async {

    final snapshot = await FirebaseFirestore.instance
        .collection('users2')
        .where('uid', isEqualTo: '${user?.uid}')
        .get();
    setsOrigen_Desc= snapshot.docs.first['Desc'];
    setsOrigen_Desc.add(_controllerDesc.text.trim());

    return setsOrigen_Desc;
  }
  Future<List> ListFechaO() async {

    final snapshot = await FirebaseFirestore.instance
        .collection('users2')
        .where('uid', isEqualTo: '${user?.uid}')
        .get();
    final now = new DateTime.now();
    String formatter = DateFormat('yMd').format(now);
    setsOrigen_Fechas= snapshot.docs.first['Fecha'];
    setsOrigen_Fechas.add(formatter);

    return setsOrigen_Fechas;
  }
  Future<List> ListFechaD() async {

    final snapshot = await FirebaseFirestore.instance
        .collection('users2')
        .where('uid', isEqualTo: '1aI6vk825QRIkaJMhOz48IrhxHz2')
        .get();
    final now = new DateTime.now();
    String formatter = DateFormat('yMd').format(now);
    setsDestino_Fechas= snapshot.docs.first['Fecha'];
    setsDestino_Fechas.add(formatter);

    return setsDestino_Fechas;
  }
  //----------------------------------------------------------------------------
 Future<bool> boolCheckDestino() async {

    final snapshotOrigen = await  FirebaseFirestore.instance
        .collection('users2')
        .where('uid', isEqualTo: '1aI6vk825QRIkaJMhOz48IrhxHz2').get();
    if(await snapshotOrigen.docs.first['uid']=='1aI6vk825QRIkaJMhOz48IrhxHz2'){
      print(snapshotOrigen.docs.first['uid']+'gggg');
      return true ;
    }

    return false ;

  }
  Future<List> ListTRansferO() async {
    final snapshotOrigen = await FirebaseFirestore.instance
        .collection('users2')
        .where('uid', isEqualTo: '${user?.uid}')
        .get();
    setsOrigen= snapshotOrigen.docs.first['Transacciones '];
    setsOrigen.add(-1 * int.parse(_controllereuro.text.trim()));
    return setsOrigen;
  }


  selectCard(cardTitle) {
    setState(() {
      selectedCard = cardTitle;
    });
  }
  checkConnection(int i ) async {
    if(i==1) {
      return AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        title: 'No Succes',
        desc: 'Scan the code again',
        btnOkOnPress: () {},
      )
        ..show();
    }
    else{
      return AwesomeDialog(
          context: context,
          dialogType: DialogType.SUCCES,
          animType: AnimType.RIGHSLIDE,
          title: 'Succes',

        btnCancelOnPress: () {
          Navigator.pop(context);
        },
        btnOkOnPress: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (BuildContext context) => Pages_2()));
        },
      )..show();
    }





}

}