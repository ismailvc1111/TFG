import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'Login.dart';
import '../Onboarding/Onboarding.dart';

class SignupPageWidget extends StatefulWidget {
  @override
  SignupPage createState() =>SignupPage();
  }
  class SignupPage extends State<SignupPageWidget> {
  final EmailmyController = TextEditingController();
  final PasswordController = TextEditingController();
  final ConfirmpassController = TextEditingController();
  final NameController = TextEditingController();
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,),


        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text("Sign up",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,

                  ),),
                  SizedBox(height: 20,),
                  Text("Create an account, It's free ",
                    style: TextStyle(
                        fontSize: 15,
                        color:Colors.grey[700]),)


                ],
              ),
              Column(
                children: <Widget>[
                  TextField(
                    controller: NameController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.account_box_outlined),
                      hintText: 'Name',
                      label: Text("Name"),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: EmailmyController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                      prefixIcon: Icon(Icons.mail),
                      border: OutlineInputBorder(),
                      hintText: 'Email',
                      label: Text("Email"),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: PasswordController,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                      prefixIcon: Icon(Icons.password),
                      border: OutlineInputBorder(),
                      hintText: 'Password',
                      label: Text("Password"),

                    ),
                  ),
                     SizedBox(height: 20),
                  Container(
                    child: TextField(
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                     style: TextStyle(
                         color: Colors.black
                     ),
                      controller: ConfirmpassController,
                      decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                        prefixIcon: Icon(Icons.password),
                        border: OutlineInputBorder(),
                        hintText: 'Confirm Password',
                        label: Text("Confirm Password"),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 3, left: 3),
                decoration:
                BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border(
                      bottom: BorderSide(color: Colors.black),
                      top: BorderSide(color: Colors.black),
                      left: BorderSide(color: Colors.black),
                      right: BorderSide(color: Colors.black),
                    )
                ),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 50,
                  onPressed: () {
                    signUp();

                  },
                  color: Color(0xff0095FF),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),

                  ),
                  child: Text(
                    "Sign up", style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.white,

                  ),
                  ),

                ),



              ),

        InkWell(
            onTap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (BuildContext context) => LoginWidget()));
            },
             child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Already have an account?"),
                      Text(" Login", style:TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18
                      ),
                      )
                    ],
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }

  Future signUp() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = await FirebaseAuth.instance.currentUser;
    try {
      List<dynamic> pLikeduserId = [];
      final now = new DateTime.now();
      String formatter = DateFormat('yMd').format(now);
      pLikeduserId.add(formatter);
     await auth.createUserWithEmailAndPassword(email: EmailmyController.text.trim(), password: PasswordController.text.trim()).then((value) =>
     {
       FirebaseFirestore.instance.collection('users2').doc(value.user?.uid).set(
           {
             'name': NameController.text.trim(),
             'Email':EmailmyController.text.trim(),
             'account': 0,
             'uid': value.user!.uid,
             'Fecha':pLikeduserId,
             'Desc': pLikeduserId,
             'Transacciones ':pLikeduserId

           }),
       Navigator.push(context, MaterialPageRoute(builder: (context) => OnboardingScreen())),





     });
     //-----------------------------------------------
     print(user?.uid);


      //---------------------------------------------------------------
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        checkConnection(1,'Weak Password','The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        checkConnection(2,'Email Already In Use','The password provided is too weak.');
      }
    } catch (e) {
      print(e);
      checkConnection(3 , 'Error' ,e.toString() );

    }



  }
//alert---------------------------------------
  checkConnection(int i , String title ,String error ) async {
    if(i==1) {
      return AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        title: title,
        desc: error,
        btnOkColor: Color(0xff0095FF),
        btnOkOnPress: () {},
      )
        ..show();
    }else if(i == 3) {
      return AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        btnOkColor: Color(0xff0095FF),
        title: title,
        desc: error,


        btnOkOnPress: () {
        },
      )..show();

    }
    else{
      return AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        btnOkColor: Color(0xff0095FF),
        title: title,
        desc: error,

        btnCancelOnPress: () {
          Navigator.pop(context);
        },
        btnOkOnPress: () {
        },
      )..show();
    }





  }

}



Widget inputFile({label, obscureText = false})
{
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color:Colors.black87
        ),

      ),
      SizedBox(
        height: 5,
      ),
      TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0,
                horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.grey[400]!
              ),

            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400]!)
            )
        ),
      ),
      SizedBox(height: 10,)
    ],
  );
}
