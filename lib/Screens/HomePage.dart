import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:login_11/Screens/signup.dart';

import 'login.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(


          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 31, vertical: 51),
          child: SingleChildScrollView(
            child: Column(
              // even space distribution
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      "Welcome",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,

                      ),

                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Techwallet simple, safe and fast place to manage your finances.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 15,

                      ),)
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/welcome.png")
                      )
                  ),
                ),
                SizedBox(
                  height: 90,
                ),
                Column(
                  children: <Widget>[
                    // the login button
                    MaterialButton(
                      minWidth: double.infinity,
                      height: 50,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginWidget()));

                      },
                      // defining the shape
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: Colors.black
                          ),
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18
                        ),
                      ),
                    ),
                    // creating the signup button
                    SizedBox(height:20),
                    MaterialButton(
                      minWidth: double.infinity,
                      height: 50,
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> SignupPageWidget()));

                      },
                      color: Color(0xff0095FF),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child: Text(
                        "Sign up",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18
                        ),
                      ),
                    )

                  ],
                )



              ],
            ),
          ),
        ),
      ),
    );
  }
}
