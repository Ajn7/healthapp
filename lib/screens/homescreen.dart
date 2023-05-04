import 'package:flutter/material.dart';

import '../API/apicalls.dart';
import '../widgets/personaliinfo.dart';
import'../widgets/vitallisttile.dart';
import '../widgets/dotmenu.dart';
import'../widgets/oxygendemochart.dart';
import '../widgets/bpdemoscreen.dart';
import '../widgets/graphbutton.dart';
import '../API/model.dart';
import '../constants/divider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = '/HomeScreen';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with API {
   
  
   DataStore dataStore=DataStore();
  //bool _shouldReload = false;
  //late TooltipBehavior _tooltipBehavior;

    @override
    void initState(){
    super.initState(); 
    
    //_tooltipBehavior =  TooltipBehavior(enable: true);
     
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('HealthConnect',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
      ),
      actions: const <Widget> [
        DotMenu(),
      ],
      backgroundColor: Colors.blue,),
      body: SingleChildScrollView(
        child: Container(
          padding:const EdgeInsets.only(top:7.0),
          //height: (MediaQuery.of(context).size.height)*0.7,
          color:Colors.white,
          child:Column(
            children:<Widget>[
              VitalListTile(msg: 'Previous SPO2 Level',value:(dataStore.prev),iconData:Icons.bloodtype,),
              VitalListTile(msg: 'Previous BP Level',value:dataStore.bpprev,iconData:Icons.devices),
              const Divider(
                 //height: 100,
                 color: Colors.orange,
                 thickness: 1,
                 indent : 10,
                 endIndent : 10,      
                 ),
                 verticalSpace(20),
                 Column(
                  children: [
                  const Text('Oxygen Saturation(SpO2)',style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                  verticalSpace(10),
                  const GraphButton(w1:OxygenHomeDemoChart(),routName: 'spgraph',),
                  const Text('Blood Pressure(BP)',style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                  verticalSpace(10),
                  const GraphButton(w1:BpDemoChart(),routName: 'bpgraph',),
                 ],
                 ),
            ],
      
          ),
        ),
      ),
      drawer: const Drawer(
        child:PersonalInfoList()
      ),
    );
  }
}
