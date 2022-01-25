import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fire_login/model/user_model.dart';
import 'package:fire_login/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
 
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}
 
class _RegistrationScreenState extends State<RegistrationScreen> {

  final _auth = FirebaseAuth.instance;

  String? errorMessage;

  final _formKey = GlobalKey<FormState>();
  
  final firstNameEditingController = new TextEditingController();
  final secondNameEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmEditingController = new TextEditingController();  

  @override
  Widget build(BuildContext context) {

    final firstNameField = TextFormField(
      autofocus: false,
      controller: firstNameEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("First Name Cannot be Empty");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid name(Min. 3 Character)");
          }
        return null; 
      },
      onSaved: (value)
      {
        firstNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "First Name",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
    final secondNameField = TextFormField(
      autofocus: false,
      controller: secondNameEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("Second Name Cannot be Empty");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid name(Min. 3 Character)");
        }
        return null; 
      },
      onSaved: (value)
      {
        secondNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Second Name",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );


    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingController,
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
        emailEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordEditingController,
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
        passwordEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );


    final confirmField = TextFormField(
      autofocus: false,
      controller: confirmEditingController,
      obscureText: true,
      validator: (value) {
        if(confirmEditingController.text != 
            passwordEditingController.text) {
          return "Password dont match";
        }
      
        return null;    
      },
      onSaved: (value)
      {
        confirmEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Confirm Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
   
    final signupButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          signUp(emailEditingController.text, passwordEditingController.text);
        },
        child: Text(
          "Sign Up",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold,
          ),

        ),
      ),
    ); 

   
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },          
        ),  
      ), 
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
                    
                    firstNameField,
                    SizedBox(height: 25),
  
                    secondNameField,
                    SizedBox(height: 25),

   
                    emailField,
                    SizedBox(height: 25),

                    passwordField,
                    SizedBox(height: 25),

                    confirmField,
                    SizedBox(height: 35),  
                                      
                    signupButton,
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
  void signUp(String email, String password) async {
    if(_formKey.currentState!.validate())
    {
      await _auth.createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => {
          postDetailsToFirestore()

        }).catchError((e)
        {
          Fluttertoast.showToast(msg: e!.message);
        });
    }
  }
  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = firstNameEditingController.text;
    userModel.secondName = secondNameEditingController.text;

    await firebaseFirestore
      .collection("users")
      .doc(user.uid)
      .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully");
    
    Navigator.pushAndRemoveUntil(
      (context),
      MaterialPageRoute(builder: (context) => HomeScreen()),
      (route) => false);
       
  }
}
















