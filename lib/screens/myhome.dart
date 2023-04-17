import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/services.dart';
import 'package:healthapp/API/apicalls.dart';
import 'package:healthapp/API/model.dart';
import 'package:healthapp/constants/divider.dart';
import 'package:healthapp/constants/sharedpref.dart';
import 'package:healthapp/core/navigator.dart';
import 'package:healthapp/screens/bpgraph.dart';
import 'package:healthapp/screens/spgraph.dart';
import 'package:healthapp/screens/startup.dart';
import 'package:healthapp/widgets/measurebutton.dart';
import 'package:healthapp/screens/editinfo.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:app_settings/app_settings.dart';
import 'package:lottie/lottie.dart';
//import 'dart:io';

DataStore dataStore=DataStore();
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
              child:CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.purple),
                        ),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}', style:const TextStyle(fontSize: 10,)));
        }
        // else if(snapshot.data.isEmpty){
        //   return const Text('No data available');
        // } 
        else {
          return const HomeScreen();
        }
      },
    ));
    
    
      
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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with API {
  bool _shouldReload = false;
  late TooltipBehavior _tooltipBehavior;

    @override
    void initState(){
    super.initState(); 
    
    _tooltipBehavior =  TooltipBehavior(enable: true);
     
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('HealthConnect',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
      ),
      actions: <Widget>[
         DropdownButtonHideUnderline(
          child: SizedBox(
            width:100,
            child:DropdownButton2(
            isExpanded: true,
            isDense: true,
            customButton: const Icon(
              Icons.more_vert,
              size: 33,
              // color: Colors.red,
            ),
          //customItemsIndexes: const [3],
          //customItemsHeights: 8,
            items: [
              ...MenuItems.firstItems.map(
                        (item) =>
                        DropdownMenuItem<MenuItem>(
                          value: item,
                          child: MenuItems.buildItem(item),
                        ),
              ),
            
               ...MenuItems.secondItems.map(
                        (item) =>
                        DropdownMenuItem<MenuItem>(
                          value: item,
                          child: MenuItems.buildItem(item),
                        ),
              ),
              const DropdownMenuItem<Divider>(enabled: false, child: Divider()),
              ...MenuItems.thirdItems.map(
                        (item) =>
                        DropdownMenuItem<MenuItem>(
                          value: item,
                          child: MenuItems.buildItem(item),
                           
                        ),
              ),
            ],
            onChanged: (value) {
              MenuItems.onChanged(context, value as MenuItem);
            },
            itemHeight: 28,
            //itemWidth: 160,
            itemPadding: const EdgeInsets.only(left: 0, right: 0),
            dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.white,
            ),
            dropdownElevation: 8,
            offset: const Offset(0, 8),
          ),
          ),
                 ),
      ],
      backgroundColor: Colors.blue,),
      body: SingleChildScrollView(
        child: Container(
          padding:const EdgeInsets.only(top:7.0),
          //height: (MediaQuery.of(context).size.height)*0.7,
          color:Colors.white,
          child:Column(
            children:<Widget>[
              ListTile(
                title:const Text(
                'Previous SPO2 Level',
                style: TextStyle(
                  fontSize: 20.0,
                ),
                ),
               subtitle:Text('${dataStore.prev}',style: const TextStyle(
                  fontSize: 20.0,
                ),
                ),
               leading: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                   SizedBox(
                    height: (MediaQuery.of(context).size.height)*0.2,
                    child:const CircleAvatar(
                      radius: 20.0,
                      backgroundColor: Colors.white60,
                      child:Icon(
                        Icons.bloodtype,
                        color:Colors.red,
                        size: 30.0,
                      ),
                    )
                  ),
                ],
               ),
              ),
      
             ListTile(
                title:const Text(
                  'Previous BP Level',
                style: TextStyle(
                  fontSize: 20.0,
                ),
                ),
               subtitle:Text('${dataStore.bpprev}',style:const TextStyle(
                  fontSize: 20.0,
                ),
                ),
               leading: Row(
                mainAxisSize: MainAxisSize.min,
                children: const <Widget>[
                  CircleAvatar(
                    radius: 20.0,
                    backgroundColor: Colors.white60,
                    child:Icon(
                      Icons.devices,
                      color:Colors.blue,
                      size: 20.0,
                    ),
                  ),
                ],
               ),
              ) ,
             Container(
              //height: (MediaQuery.of(context).size.height)*0.4,
              padding: const EdgeInsets.only(top:7.0),
              width: MediaQuery.of(context).size.width,
              color:Colors.grey.shade100,
              child: Column(
                children : [ 
      
                    horizontaSpace(20),
                    const Text("SPO2",style: TextStyle(fontSize: 25,color: Colors.green),),
                    horizontaSpace(20),
                 
                verticalSpace(20),
                    Row(
                      children: [
                        SizedBox(
                          height: 200,
                          width: 200,
                      child: SfCartesianChart(
                        // Enables the legend
                         // legend: Legend(isVisible: true),
                        //title: ChartTitle(text: ' analysis'),
                          // Initialize category axis
                          tooltipBehavior: _tooltipBehavior,
                          primaryXAxis: CategoryAxis(),
                          series: <ChartSeries>[
                              // Initialize line series
                              LineSeries<ChartData, dynamic>(
                                  dataSource: [
                                      // Bind data source
                                      ChartData('Jan 1', 35),
                                      ChartData('Jan 2', 28),
                                      ChartData('Jan 3', 34),
                                      ChartData('Jan 4', 32),
                                      ChartData('Jan 5', 40)
                                  ],
                                  xValueMapper: (ChartData data, _) => data.x,
                                  yValueMapper: (ChartData data, _) => data.y,
                                  // Render the data label
                                  dataLabelSettings:const DataLabelSettings(isVisible : true)
                              )
                          ]
                      )
                  ),
                  horizontaSpace(20),
                  MeasureButton(buttonText: 'Measure', buttonAction: () { 
                         // getData();
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const SpoGraphscreen()));
                           
                        }),
                      ],
                    ),
                 horizontaSpace(20),
                    const Text("BP",style: TextStyle(fontSize: 25,color: Colors.green),),
                    horizontaSpace(20),
                 
                verticalSpace(20),
                    Row(
                      children: [
                        SizedBox(
                          height: 200,
                          width: 200,
                      child: SfCartesianChart(
                        // Enables the legend
                         // legend: Legend(isVisible: true),
                        //title: ChartTitle(text: ' analysis'),
                          // Initialize category axis
                          tooltipBehavior: _tooltipBehavior,
                          primaryXAxis: CategoryAxis(),
                          series: <ChartSeries>[
                              // Initialize line series
                              LineSeries<ChartData, dynamic>(
                                  dataSource: [
                                      // Bind data source
                                      ChartData('Jan 1', 35),
                                      ChartData('Jan 2', 28),
                                      ChartData('Jan 3', 34),
                                      ChartData('Jan 4', 32),
                                      ChartData('Jan 5', 40)
                                  ],
                                  xValueMapper: (ChartData data, _) => data.x,
                                  yValueMapper: (ChartData data, _) => data.y,
                                  // Render the data label
                                  dataLabelSettings:const DataLabelSettings(isVisible : true)
                              )
                          ]
                      )
                  ),
                  horizontaSpace(20),
                  MeasureButton(buttonText: 'Measure', buttonAction: () { 
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const BPScreen()));
                        }),
                      ],
                    ),
                ],
              ),
             ),
            ],
      
          ),
        ),
      ),
      drawer: Drawer(
        child:ListView(
          children: [
            UserAccountsDrawerHeader(
            accountName: Text(dataStore.name.toUpperCase(),
            style:const TextStyle(
              fontSize: 21.0,
            ),
            ), 
            accountEmail:Text(dataStore.email),
            otherAccountsPictures: <Widget>[
              IconButton(
              icon: const Icon(Icons.edit),
              color:Colors.white,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const EditInfo()));
               },
              ),
            ],
                    currentAccountPicture:const CircleAvatar(
            backgroundImage: AssetImage('assets/images/profile.png'),
                    ),
            ),
           ListTile(
            leading:const Icon(Icons.person_outline),
            title: Text("Age :${dataStore.age}"),
            //onTap: () { },
          ),
           ListTile(
            leading:const Icon(Icons.expand),
            title: Text("Height :${dataStore.height}"),
            //onTap: () { },
          ),
           ListTile(
            leading:const Icon(Icons.local_florist),
            title: Text("weight :${dataStore.weight}"),
            //onTap: () { },
          ),
           ListTile(
            leading:const Icon(Icons.volunteer_activism),
            title: Text("Blood Group :${dataStore.bloodgroup}"),
            //onTap: () { },
          ),
          // const ListTile(
          //   leading: Icon(Icons.emoji_emotions),
          //   title: Text("Gender :"),
          //   //onTap: () { },
          // ),
          // const ListTile(
          //   leading: Icon(Icons.insights),
          //   title: Text("Cholestrol level :"),
          //   //onTap: () { },
          // ),
          // const ListTile(
          //   leading: Icon(Icons.query_stats),
          //   title: Text("Sugar Level :"),
          //   //onTap: () { },
          // ),
            ListTile(
            leading:const Icon(Icons.phone),
            title: Text("Phone :${dataStore.phone}"),
           // onTap: () { },
          ),
          const Divider(
            height:10,
            color:Colors.black45
          ),
          ListTile(
            leading: const Icon(Icons.password),
            title: const Text("Change Password"),
            onTap: () { },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text("Log Out"),
            onTap: () async {
              //SharedPreferences pref = await SharedPreferences.getInstance();
              //pref.remove(tokens);
              MySharedPreferences myPrefs = MySharedPreferences();
              await myPrefs.initPrefs();  
              await myPrefs.remove('token');
              await myPrefs.remove('name');
              await myPrefs.remove('email');
              await myPrefs.remove('user_id');
              navigatorKey?.currentState?.pushReplacementNamed("loginscreen");
             },
          ),
          ],
        )
      ),
    );
  }
}

class MenuItem {
  final dynamic text;
  final IconData icon;

  const MenuItem({
    required this.text,
    required this.icon,
  });
}

class MenuItems {
  static const List<MenuItem> firstItems = [help]; // [home, share, settings];
  static const List<MenuItem> secondItems = [share];
  static const List<MenuItem> thirdItems = [logout];

  //static const home = MenuItem(text: 'Home', icon: Icons.home);
  
  static const help = MenuItem(text: 'Help', icon: Icons.help_outline);
  static const share = MenuItem(text: 'Share', icon: Icons.share);
  static const logout = MenuItem(text: 'Log Out', icon: Icons.logout);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Icon(
                  item.icon,
                  color: Colors.black,
                  size: 20
          ),
        ),
        horizontaSpace(10),
        Text(
          item.text,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  

  static onChanged(BuildContext context, MenuItem item) async {
    switch (item) {
      //case MenuItems.home:
      //Do something
       // break;
      case MenuItems.help:
          navigatorKey?.currentState?.pushNamed("help");
      //Do something
       break;
      case MenuItems.share:
        //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>  Sample()));
        break;
      case MenuItems.logout:{   
        //SharedPreferences prefs= await SharedPreferences.getInstance();
        // pref.remove(tokens);    
       MySharedPreferences myPrefs = MySharedPreferences();
       await myPrefs.initPrefs();  
       await myPrefs.remove('token');
       await myPrefs.remove('name');
       await myPrefs.remove('email');
       await myPrefs.remove('user_id');
      navigatorKey?.currentState?.pushReplacementNamed("loginscreen");
      }
    }
  }
  
}

class ChartData {
        ChartData(this.x, this.y);
        final dynamic x;
        final double? y;
    }

    