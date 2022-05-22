import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class qr_page extends StatefulWidget {
  const qr_page({Key? key}) : super(key: key);

  @override
  State<qr_page> createState() => _qr_pageState();
}

class _qr_pageState extends State<qr_page> {
  var qrsc = "Escaneame";
  var height , width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Scanning Qr code '),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(qrsc,style: TextStyle(color: Colors.blue,fontSize: 30),),
            ElevatedButton(onPressed: (){
              scaQr();
            }, child: Text('Scanner')),
            SizedBox()

          ],
        ),
      ),);
  }
  Future <void>scaQr()  async{
    try{
      FlutterBarcodeScanner.scanBarcode('#2A99C', 'cancel', true, ScanMode.QR).then((value){
        setState(() {
          qrsc=value;
        });
      } );
    }catch(e){
      setState(() {
        qrsc = 'error';
      });
    }
  }



}
