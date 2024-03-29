import 'package:flutter/material.dart';
import 'package:healthapp/constants/divider.dart';

import '../API/model.dart';
import '../constants/sharedpref.dart';
import '../core/navigator.dart';
import '../screens/login.dart';
import '../constants/headline.dart';
import '../widgets/wavetext.dart';

//import '../widgets/progressindicator.dart';
//import 'package:shared_preferences/shared_preferences.dart';

DataStore dataStore=DataStore();
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
  dataStore.name =myPrefs.getString('name').toString();
  dataStore.email =myPrefs.getString('email').toString();
  dataStore.id =myPrefs.getInt('user_id');
  
  //dta=myPrefs.getList('readingList');
  
  print('Token of statup(shpf) :$myToken');
  print('name at statup (shpf) :${dataStore.name}');
  print('email at statup (shpf):${dataStore.email}');
  print('id at statup (shpf):${dataStore.id}');
  print('Shared Time list ::: ${myPrefs.getList('time')}');

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
         const Text('Loading...'),
         verticalSpace(5),
         const WaveText(),
          //const Progressindicator(),
              
            ],
          ),
        )
    );
    
  }
}






