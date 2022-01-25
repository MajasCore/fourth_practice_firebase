import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:fire_login/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';


class OtpScreen extends StatefulWidget {
  final String phone;
  OtpScreen(this.phone);
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String? _verificationCode;
  final TextEditingController _pinOTPCodeController = TextEditingController();
  final FocusNode _pinOTPCodeFocusNode = FocusNode();

  final BoxDecoration pinOTPCodeDecoration = BoxDecoration(
    color: Colors.grey,
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: Colors.black,
    ),
  );

  @override
  void initState() {
    super.initState();

    verifyPhoneNumber();

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: Colors.redAccent,
        elevation: 0,
        title: Text("OTP Login",style: TextStyle( color: Colors.black),), centerTitle: true,
      ),
      body: Center( child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 40),
            child: Center(
              child: Text(
                'Verify +91-${widget.phone}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: PinPut(
              fieldsCount: 6,
              textStyle: const TextStyle(fontSize: 25.0, color: Colors.white),
              eachFieldWidth: 30.0,
              eachFieldHeight: 45.0,
              focusNode: _pinOTPCodeFocusNode,
              controller: _pinOTPCodeController,
              submittedFieldDecoration: pinOTPCodeDecoration,
              selectedFieldDecoration: pinOTPCodeDecoration,
              followingFieldDecoration: pinOTPCodeDecoration,
              pinAnimationType: PinAnimationType.fade,
              onSubmit: (pin) async
              {
                try{
                  await FirebaseAuth.instance
                      .signInWithCredential(PhoneAuthProvider
                      .credential(verificationId: _verificationCode!, smsCode: pin))
                      .then((value) {
                        if(value.user != null)
                        {
                          Navigator.of(context).push(MaterialPageRoute(builder: (c) => HomeScreen()));
                        }     
                  });
                }
                catch(e){
                  FocusScope.of(context).unfocus();
                  print('error');
                }

              } 
            ),
          )
        ],
      ),),
    );
  }

  verifyPhoneNumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${widget.phone}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
             if(value.user != null)
                        {
                          Navigator.of(context).push(MaterialPageRoute(builder: (c) => HomeScreen()));
                        } 
            
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message); 
        },
        codeSent: (String vID, int? resendToken) {
          setState(() {
            _verificationCode = vID;
          });
        },
        codeAutoRetrievalTimeout: (String vID) {
          setState(() {
            _verificationCode = vID;
          });
        },
        timeout: Duration(seconds: 120));
  }

}
