import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:app_settings/app_settings.dart';
import 'package:lottie/lottie.dart';

import '../API/apicalls.dart';
import '../screens/startup.dart';
import '../widgets/progressindicator.dart';
import '../screens/homescreen.dart';



bool connection=false;
class MyHome extends StatefulWidget {
   
    const MyHome({super.key});
  //final dynamic token;
  //const MyHome({Key? key,required this.token}) : super(key: key);
  
  
  @override
  State<MyHome> createState() => _MyHomeState();

  
}

class _MyHomeState extends State<MyHome> with API{
   late Future<dynamic>_futureData=Future.value('initial value');
   @override
    void initState(){
    super.initState();
    getLastData();
    checkInternetConnectivity();
    _futureData=getUserData();
    // getReading(date: DateTime.now().toString(), vitalid: 1);
    // getReadingBp(date: DateTime.now().toString().substring(0,10), vitalid: 2);
    // _futureData=getUserData();

    }
    // getData()async{
    //   MySharedPreferences myPrefs = MySharedPreferences();
    //   await myPrefs.initPrefs();
    //   setState(() {
    //   dataStore.name =myPrefs.getString('name').toString();
    //   dataStore.email =myPrefs.getString('email').toString();
    //   });
      
    // }
  
  @override
  Widget build(BuildContext context){
    
      return ( FutureBuilder<dynamic>(
      future:_futureData,
      initialData: const ['Loading...'],
      builder:(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            color:Colors.white,
            child:const Center(
              child:Progressindicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}', 
            style:const TextStyle(fontSize: 10,),
            ),
            );
        }
        else {

              return  const HomeScreen();
        }
      },
    )
    ); 
  }

  Future<bool> checkInternetConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
    getReading(date: DateTime.now().toString(), vitalid: 1);
    getReadingBp(date: DateTime.now().toString().substring(0,10), vitalid: 2);
    _futureData=getUserData();//.then((_){
    //   setState(() {
        
    //   });
    // });
      return true;
    } else {
      showAlertDialog(context);
      return false;
    }
  }

  showAlertDialog(context) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child:const Text("Cancel"),
    onPressed:  () {
      showAlertDialogofClose(context);
      //exit(0);
      //quit application
    },
  );
  
  Widget continueButton = TextButton(
    child:const Text("settings"),
    onPressed:  () async{
      AppSettings.openWIFISettings(callback: () {
                    NavigatorState navigator = Navigator.of(context);
                    navigator.popUntil((route) => route.isFirst);
                    navigator.pushReplacement(MaterialPageRoute(builder: (context) => const Startup()));
                  });
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title:const Text("No Internet connection"),
    content: SizedBox(
      width: 200,
      height:250,
      child: Column(
        children: [
          const Text("Internet is currently unavailable. Please click settings to turn on your device's internet connection to continue."),
          Lottie.asset('assets/images/nointernet.json',height: 150, width: 150)
        ],
      ),
    ),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
   showDialog(
    context: context,
    builder: (BuildContext context) {
      return WillPopScope(
      onWillPop: () async {
        showAlertDialogofClose(context);
        return false;
      }, child: alert,
  );
    }
  );
  
}
showAlertDialogofClose(BuildContext context) {
//   set up the buttons
  Widget cancelButton = TextButton(
    child:const Text("Yes"),
    onPressed:  () {
      Navigator.pop(context);
      SystemNavigator.pop();
      
    },
  );
  Widget continueButton = TextButton(
    child:const Text("No"),
    onPressed:  () {
     Navigator.pop(context);
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title:const Text("Alert"),
    content: const Text("Do you want to close app?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return alert;
    },
  );
}

}


   