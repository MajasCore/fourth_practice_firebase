import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fire_login/login_page.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:math' as math;
import 'package:fire_login/storage_service.dart'; 


class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
} 

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    return Scaffold(
      backgroundColor: Color(0xff472154),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget> [
              Stack(
                fit: StackFit.passthrough,
                overflow: Overflow.visible,     
                children: <Widget>[
                  Container(
                    height: 300,
                    width: double.infinity,
                     
                   
                  ),
                  Positioned(
                    top: 60,
                    right: 0,
                    child: Transform.rotate(
                      angle: math.pi/12.0,
                      child: Image.asset(
                        'assets/gallery.png',
                        height: 180,
                        width: 180,
                      ),
                    ),  
                  ),
                  Positioned(
                    top: 20,
                    left: 110,
                    child: Transform.rotate(
                      angle: -math.pi/12.0,
                      child: Image.asset(
                        'assets/music.png',
                        height: 80,
                        width: 80,
                      ),
                    ),  
                  ),
                   Positioned(
                    top: 80,
                    left: 20,
                    child: Transform.rotate(
                      angle: math.pi/12.0,
                      child: Image.asset(
                        'assets/vedio.png',
                        height: 130,
                        width: 130,
                      ),
                    ),  
                  ),
      
                ]
              ),
              Container(
                width: double.infinity,
                height: 400.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20), 
                ),
                child: Column(
                  children: <Widget> [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Upload your file',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff472154),
                      ),
                    ),
                    Container(
                     height: 250, 
                    ),
                    ElevatedButton(
                      child: Text('Upload your file'),
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(300, 60),
                        primary: Color(0xffFEB349),
                        onPrimary: Colors.white,
                        onSurface: Colors.grey,
                        shadowColor: Colors.red,
                        elevation: 10,
                        textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                        ),
                      ),
                      onPressed: () async {
                        final results = await FilePicker.platform.pickFiles(
                          allowMultiple: false,
                          type: FileType.custom,
                          allowedExtensions: ['png', 'jpg'], 
                        );

                        if (results == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('No file selected'),
                            ), 
                          );
                          return null;
                        } 

                        final path = results.files.single.path!;
                        final fileName = results.files.single.name;

                        storage
                            .uploadFile(path, fileName)
                            .then((value) => print('Done')); 
                      }, 
                   ),

                    
                  ]
                ),   
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
