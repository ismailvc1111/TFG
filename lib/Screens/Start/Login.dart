import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_11/Screens/pages2.dart';
import 'package:login_11/Screens/Start/Signup.dart';
class LoginWidget extends StatefulWidget {
  @override
  LoginPage createState() =>LoginPage();
}
class LoginPage extends State<LoginWidget> {
  @override
  final EmailmyController = TextEditingController();
  final PasswordController = TextEditingController();

  void dispose() {
    EmailmyController.dispose();
    PasswordController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      body: Container(
        height: MediaQuery
            .of(context)
            .size
            .height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text("Login",
                      style: TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),),
                    SizedBox(height: 20,),
                    Text("Login to your account",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[700]),)
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20),
                      TextField(
                        controller: EmailmyController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 2),
                          prefixIcon: Icon(Icons.account_box_outlined),
                          border: OutlineInputBorder(),
                          hintText: 'Email',
                          label: Text("Email"),
                        ),
                      ),
                      SizedBox(height: 23),
                      TextField(
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        controller: PasswordController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 2),
                          prefixIcon: Icon(Icons.password),
                          border: OutlineInputBorder(),
                          hintText: 'Password',
                          label: Text("Password"),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(padding:
                EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
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
                        signIn();
                      },
                      color: Color(0xff0095FF),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),

                      ),
                      child: Text(
                        "Login", style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white,

                      ),
                      ),

                    ),
                  ),
                ),
                InkWell(
                  //pressioned
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => SignupPageWidget()));
                  },
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Don't have an account?"),
                          Text(" Sign up", style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,

                          ),)
                        ],
                      ),
                    ],
                  ),),

                Container(
                  padding: EdgeInsets.only(top: 100),
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/background.png"),
                        fit: BoxFit.fitHeight
                    ),

                  ),
                )

              ],
            ))
          ],
        ),
      ),
    );
  }
//ALert Diaglog
  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: EmailmyController.text.trim(),
          password: PasswordController.text.trim());
      FirebaseAuth.instance
          .authStateChanges()
          .listen((User? user) {
        if (user == null) {
          print('User is currently signed out!');
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (BuildContext context) => Pages_2()));
        }
      });
    }
    on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        checkConnection(1);
      } else if (e.code == 'wrong-password') {
        checkConnection(2);
      }
    }
  }
//------------------------------------------------
  checkConnection(int i  ) async {
    if(i==1) {
      return AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        title: 'User not found',
        desc: 'No user found for that email.',
        btnOkColor: Color(0xff0095FF),
        btnOkOnPress: () {},
      )
        ..show();
    }
    else{
      return AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        btnOkColor: Color(0xff0095FF),
        title: 'Wrong password',
        desc: 'Wrong password provided for that user.',

        btnOkOnPress: () {
        },
      )..show();
    }





  }
  Widget inputFile({label, obscureText = false, controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.black87
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
}