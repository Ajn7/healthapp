import 'package:flutter/material.dart';
import 'package:healthapp/main.dart';
import 'package:healthapp/screens/login.dart';
import 'package:healthapp/screens/myhome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/headline.dart';



class Startup extends StatefulWidget {
  const Startup({super.key});
  // @override
  // void initState() {
  // checkUserLogedin();
  // }

 
  @override
  State<Startup> createState() => _StartupState();
}

class _StartupState extends State<Startup> {
  
  @override
  Widget build(BuildContext context) {

  Future<void> checkUserLogedin() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs =await SharedPreferences.getInstance();
  var token=prefs.getString('$tokens');
  print('Token of statup $token');
  token==null?Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginScreen())):Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MyHome(email:email,token:token)));
  
  }
   checkUserLogedin();
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
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
                    },
                    child: const SizedBox(height: 20,),
                   ),
                ),
              ),
              Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: IconButton(
                      icon: const Icon(
                        Icons.logout,
                      ),
                      iconSize: 50,
                      color:const Color(0xFFB80075),
                      splashColor: Colors.grey,
                      onPressed: () {
                       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
                      },
                    ),
                  )),
            ],
          ),
        )
    );
    
  }

  // Future<void> checkUserLogedin() async{
  //  final _sharedpref = await SharedPreferences.getInstance();
  //  final _userLoggedIn = _sharedpref.getBool(save_key_name);
  //  if (_userLoggedIn ==null || _userLoggedIn==false) 
  //  {
  //   LoginScreen();
  //  }
  //  else {
  //   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyHome(email: 'email', password:'phone')));
  //  }
  //  }
}


