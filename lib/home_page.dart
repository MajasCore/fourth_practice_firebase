import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fire_login/login_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
} 

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        elevation: 0,
        title: Text("Welcome",style: TextStyle( color: Colors.black),), centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget> [
              SizedBox(
                height: 100,
                child: Image.asset("assets/logo.png", fit: BoxFit.contain),
              ),
              Text(
                "Welcome Back",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Name",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),   
              ),
              Text(
                "Email",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),   
              ),
              SizedBox(
                height: 15
              ), 
              ActionChip( 
                label: Text("Logout"),
                onPressed: () {
                  logout(context);       
                }
              ),      
            ]
          ),   
        ),
      ),
    );
  }
  
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => LoginScreen())
    ); 

  }

}
