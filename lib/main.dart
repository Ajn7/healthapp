import 'package:flutter/material.dart';
import 'screens/startup.dart';


var tokens='';
var email='';
//dynamic save_key_name = 'save_key_name';
void main() {
 
   // to hide only status bar
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
 

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.black,
        ),
        home: Startup()
    );
  }
}


