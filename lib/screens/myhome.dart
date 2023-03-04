import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:healthapp/API/apicalls.dart';
import 'package:healthapp/API/model.dart';
import 'package:healthapp/constants/divider.dart';
import 'package:healthapp/main.dart';
import 'package:healthapp/screens/bpgraph.dart';
import 'package:healthapp/screens/spgraph.dart';
import 'package:healthapp/widgets/measurebutton.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:healthapp/screens/editinfo.dart';
import 'package:healthapp/screens/login.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
class MyHome extends StatefulWidget {

  String token;
  MyHome({Key? key,required this.token}) : super(key: key);
  @override
  _MyHomeState createState() => _MyHomeState();

  
}

class _MyHomeState extends State<MyHome> {
  late TooltipBehavior _tooltipBehavior;


@override
    void initState(){
      getReading();
      getUserData();
      _tooltipBehavior =  TooltipBehavior(enable: true);
      super.initState(); 
    }
  
  
  @override
  Widget build(BuildContext context) {
    //print("inside my home $token");
    print('em:$email');
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
      body: Container(
        padding:const EdgeInsets.only(top:7.0),
        //height: (MediaQuery.of(context).size.height)*0.7,
        color:Colors.white,
        child:Column(
          children:<Widget>[
            ListTile(
              title:const Text(
                'Previous BP Level',
              style: TextStyle(
                fontSize: 20.0,
              ),
              ),
             subtitle: const Text('150',style: TextStyle(
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
                'Previous SPO2 Level',
              style: TextStyle(
                fontSize: 20.0,
              ),
              ),
             subtitle: const Text('100',style: TextStyle(
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
                        // Initialize category axis
                        primaryXAxis: CategoryAxis(),
                        series: <ChartSeries>[
                            // Initialize line series
                            LineSeries<ChartData, String>(
                                dataSource: [
                                    // Bind data source
                                    ChartData('Jan 1', 35),
                                    ChartData('Jan 2', 28),
                                    ChartData('Jan 3', 34),
                                    ChartData('Jan 4', 32),
                                    ChartData('Jan 5', 40)
                                ],
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y
                            )
                        ]
                    )
                ),
                horizontaSpace(20),
                MeasureButton(buttonText: 'Measure', buttonAction: () { 
                        getData();
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
                            LineSeries<ChartData, String>(
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
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => BPScreen()));
                      }),
                    ],
                  ),
              ],
            ),
           ),
          ],

        ),
      ),
      drawer: Drawer(
        child:ListView(
          children: [
            UserAccountsDrawerHeader(
            accountName: Text(name,
            style:const TextStyle(
              fontSize: 21.0,
            ),
            ), 
            accountEmail:Text(email),
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
          const ListTile(
            leading: Icon(Icons.person_outline),
            title: Text("Age :"),
            //onTap: () { },
          ),
          const ListTile(
            leading: Icon(Icons.expand),
            title: Text("Height :"),
            //onTap: () { },
          ),
          const ListTile(
            leading: Icon(Icons.local_florist),
            title: Text("weight :"),
            //onTap: () { },
          ),
          const ListTile(
            leading: Icon(Icons.volunteer_activism),
            title: Text("Blood Group :"),
            //onTap: () { },
          ),
          const ListTile(
            leading: Icon(Icons.emoji_emotions),
            title: Text("Gender :"),
            //onTap: () { },
          ),
          const ListTile(
            leading: Icon(Icons.insights),
            title: Text("Cholestrol level :"),
            //onTap: () { },
          ),
          const ListTile(
            leading: Icon(Icons.query_stats),
            title: Text("Sugar Level :"),
            //onTap: () { },
          ),
           const ListTile(
            leading: Icon(Icons.phone),
            title: Text("Phone :"),
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
              SharedPreferences pref = await SharedPreferences.getInstance();
              pref.remove(tokens);
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>const LoginScreen()));
             },
          ),
          ],
        )
      ),
    );
  }
}


class MenuItem {
  final String text;
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
        const SizedBox(
          width: 10,
        ),
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
      //Do something
       break;
      case MenuItems.share:
        //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>  Sample()));
        break;
      case MenuItems.logout:{   
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.remove(tokens);        
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginScreen())); 
        break;
      }
    }
  }
}

class ChartData {
        ChartData(this.x, this.y);
        final String x;
        final double? y;
    }