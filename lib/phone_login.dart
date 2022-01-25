import 'package:flutter/material.dart';
import 'package:fire_login/otp_screen.dart'; 

class PhoneLogin extends StatefulWidget{
  const PhoneLogin({Key? key}) : super(key: key);

  @override
  _PhoneLoginState createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {

  final nextButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,  
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,  
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                OtpScreen(_controller.text)));

        },
        child: Text(
          "Next",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold,
          ),
           
        ),
      ), 
    ); 
  
    return Scaffold(
       appBar: AppBar(
        backgroundColor: Colors.redAccent,
        elevation: 0,
        title: Text("OTP Login",style: TextStyle( color: Colors.black),), centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(36),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget> [
                Text(
                  'Enter Phone Number',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),

                SizedBox(height: 20),
 
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Phone Number',
                    prefix: Padding(
                      padding: EdgeInsets.all(4),
                      child: Text('+91'),
                    ),
                  ),
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  controller: _controller, 
                ),
                 
                SizedBox(height: 25),
 
                nextButton, 
              ]
            ),    
          ),
        ),
      ), 
    );
  }
}

