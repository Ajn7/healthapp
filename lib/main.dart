import 'package:flutter/material.dart';
import './constants/headline.dart';
void main() {
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
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
            children:[headline(),Align(
              alignment: Alignment.center,
              child:Padding(
              padding:EdgeInsets.only(top:10,bottom:55),
              child:  TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {},
            child: const Text("Welcome to HealthConnect \n click here to explore us",style: TextStyle(color:Color.fromARGB(255, 10, 203, 65),fontWeight: FontWeight.bold)),
          ),
            ),),
            Align(
            alignment: Alignment.topCenter,  
            child:Padding(
              padding:EdgeInsets.only(top:106),
              child:IconButton(
              icon: Icon(
              Icons.logout,
              ),
            iconSize: 50,
            color: Color(0xFFB80075),
            splashColor: Colors.grey,
            onPressed: () {},
          ),)),

],
          ),

        
      )
    );
  }
}



 
//Text("Welcome to HealthConnect"),Text("click here to explore us")