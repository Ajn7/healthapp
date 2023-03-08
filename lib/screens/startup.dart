import 'package:flutter/material.dart';
import 'package:healthapp/API/model.dart';
import 'package:healthapp/constants/sharedpref.dart';
import 'package:healthapp/core/navigator.dart';
//import 'package:healthapp/main.dart';
import 'package:healthapp/screens/login.dart';
import 'package:healthapp/screens/myhome.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import '../constants/headline.dart';

class Startup extends StatefulWidget {
  const Startup({super.key});
 
  @override
  State<Startup> createState() => _StartupState();
}

class _StartupState extends State<Startup> {
  @override
    void initState(){
      Future<void> checkUserLogedin() async{
  //shared preferences
  // WidgetsFlutterBinding.ensureInitialized();
  // SharedPreferences prefs =await SharedPreferences.getInstance();
  // token=prefs.getString(tokens);
  //print('Token of statup $token');
  //bool keyRemoved = await myPrefs.remove('myKey');
  MySharedPreferences myPrefs = MySharedPreferences();
  await myPrefs.initPrefs();
  String? myToken =myPrefs.getString('token');
  name =myPrefs.getString('name').toString();
  email =myPrefs.getString('email').toString();
  id =myPrefs.getInt('user_id');
  
  //dta=myPrefs.getList('readingList');
  
  print('Token of statup(shpf) :$myToken');
  print('name at statup (shpf) :$name');
  print('email at statup (shpf):$email');
  print('id at statup (shpf):$id');
  //print('email at statup (shpf):$dta');
  
  
  //myToken==null?Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginScreen())):Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MyHome(token:myToken)));
  myToken==null?navigatorKey?.currentState?.pushReplacementNamed("loginscreen"):navigatorKey?.currentState?.pushReplacementNamed("homescreen");
  }
  Future.delayed(const Duration(seconds: 3), (){
      checkUserLogedin();
});
      super.initState(); 
    }
  @override
  Widget build(BuildContext context) {
 
  
  
    return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child:Column(
            children: [
              headline(),
              Image.asset(
                'assets/images/startup.png',
                    height: 300,
                    width: 300,
                  //color: Colors.red,
                    colorBlendMode: BlendMode.darken,
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 25),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginScreen()));
                    },
                    child: const SizedBox(height: 20,),
                   ),
                ),
              ),
              const CircularProgressIndicator(

              valueColor: AlwaysStoppedAnimation<Color>(

                  Colors.purple),

                  ),
              
            ],
          ),
        )
    );
    
  }
}




