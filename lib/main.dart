import 'package:flutter/material.dart';
import './constants/headline.dart';
import 'startup.dart';

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
          primarySwatch: Colors.purple,
          primaryColor: Color.fromRGBO(184, 0, 117, 1),
        ),
        home: Startup()
    );
  }
}

// void _navigateToNextScreen(BuildContext context) {
  
// }
