import 'package:flutter/material.dart';
import 'package:fire_login/signup_screen.dart'; 
import 'package:fire_login/home_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fire_login/phone_login.dart'; 

class LoginScreen extends StatefulWidget{
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();


  final _auth = FirebaseAuth.instance; 


  @override
  Widget build(BuildContext context) {

    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if(value!.isEmpty)
        {
          return ("Please Enter Your Email"); 
        }
        if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
          .hasMatch(value)) {
          return ("Please Enter a Valid Email"); 
        }
        return null; 
         
      },
      onSaved: (value)
      {
        emailController.text = value!; 
      }, 
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.mail),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
        border: OutlineInputBorder( 
          borderRadius: BorderRadius.circular(10),
        ),    
      ),

    );


    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: true,  
      validator: (value) {
        RegExp regx = new RegExp(r'^.{6,}$');
        if(value!.isEmpty)
          {
            return("Please Enter Your Password");   
          }
      },
      onSaved: (value)
      {
        passwordController.text = value!; 
      }, 
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
        border: OutlineInputBorder( 
          borderRadius: BorderRadius.circular(10),
        ),    
      ),
   
    );
   
    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,  
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,  
        onPressed: () {
          signIn(emailController.text, passwordController.text); 
        },
        child: Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold,
          ),
           
        ),
      ), 
    );

    final phoneButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.grey[800],  
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,  
        onPressed: () {
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) =>
                PhoneLogin()));

        },
        child: Text(
          "Phone OTP Login",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold,
          ),
           
        ),
      ), 
    );   

    

       

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(36),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 100,
                      child: Image.asset(
                        "assets/logo.png",
                        fit: BoxFit.contain, 
                      ),   
                    ),
                    SizedBox(height: 45),  
                    emailField,
                    SizedBox(height: 25),

                    passwordField,
                    SizedBox(height: 35),
                 
   
                    loginButton,
                    SizedBox(height: 15),
  

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget> [
                        Text("Don't have an account "),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context, 
                              MaterialPageRoute(
                                builder: (context) =>
                                  RegistrationScreen()));
                          },
                          child: Text(
                            "SignUp",
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.w400,
                              fontSize: 15,  
                            ),
                          ),
                        ),
                      ] 
                    ),

                    SizedBox(height: 15),

                    Container(
                      height: 1.0,
                      width: double.infinity,
                      color: Colors.grey[300],
                    ), 
                    SizedBox(height: 25), 
   
                    phoneButton,
                    SizedBox(height: 15),
 
                  ],
                ),
              ),
            ),
          ), 
        ),
      ),
    );
  }
 
  void signIn(String email, String password) async
  {
    if(_formKey.currentState!.validate())
 
    {
      await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((uid) => {
          Fluttertoast.showToast(msg: "Login Successful"),
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomeScreen())),  
          }).catchError((e)
          {
            Fluttertoast.showToast(msg: e!.message);

          });
    } 
  }

}
