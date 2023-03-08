import 'package:flutter/material.dart';
import 'package:healthapp/screens/bpgraph.dart';
import 'package:healthapp/screens/editinfo.dart';
import 'package:healthapp/screens/forgott.dart';
import 'package:healthapp/screens/login.dart';
import 'package:healthapp/screens/myhome.dart';
import 'package:healthapp/screens/signup.dart';
import 'package:healthapp/screens/spgraph.dart';
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
          "homescreen":(BuildContext ctx)=>MyHome(),
          "startup":(BuildContext ctx) => const Startup(),
          "edit":(BuildContext ctx) => const EditInfo(),
          "forgott":(BuildContext ctx) => const ForgottScreen(),
          "bpgraph":(BuildContext ctx) => const BPScreen(),
          "signup":(BuildContext ctx) => const SignupScreen(),
          "spgraph":(BuildContext ctx) => const SpoGraphscreen(),
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


