import 'package:flutter/material.dart';
import 'screens/startup.dart';

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
        // Remove the debug banner
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.black,
        ),
        home: const Startup()
    );
  }
}


