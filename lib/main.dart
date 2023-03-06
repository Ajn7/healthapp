import 'package:flutter/material.dart';
import 'package:healthapp/screens/login.dart';
import 'package:healthapp/screens/myhome.dart';
import 'core/navigator.dart';
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
        navigatorKey: navigatorKey,
        routes:{
          "loginscreen":(BuildContext ctx)=>const LoginScreen(),
          "homescreen":(BuildContext ctx)=>const HomeScreen(),
          "startup":(BuildContext ctx) => const Startup(),
        },
        initialRoute: "startup",
        title: 'Flutter Demo',
        // Remove the debug banner
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.black,
        ),
        //home: const Startup()
    );
  }
}


