import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:healthapp/API/apicalls.dart';
import 'package:healthapp/API/model.dart';
import 'package:healthapp/core/navigator.dart';
import 'package:healthapp/screens/spgraph.dart';
import 'dart:core';
import 'package:app_settings/app_settings.dart';
DataStore dataStore=DataStore();
int counter=0;
int mydvid=0;
 List <int> spo2List =[];
 late StreamSubscription<List<int>> streamSubscription;
class ConnectedBluetoothDevicesPage extends StatefulWidget  {

  const ConnectedBluetoothDevicesPage({super.key});

  @override
  State<ConnectedBluetoothDevicesPage> createState()=>_ConnectedBluetoothDevicesPageState();
 
}


class _ConnectedBluetoothDevicesPageState
    extends State<ConnectedBluetoothDevicesPage> {
  bool allowNavigation = false;
  List<BluetoothDevice> connectedDevicesList = <BluetoothDevice>[];

  @override
  void initState() {
    super.initState();
    mydvid=0;
     Future.delayed(const Duration(seconds: 3), () {
   checkBluetoothStatus(context);
  });
    
  }

  @override
  Widget build(BuildContext context) {
    scanFunction();
    return WillPopScope(
      onWillPop: () async {
        if (allowNavigation) {
          return true;
        } else {
          // Show snackbar to indicate back navigation is disabled
          ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(
              content: const Text('Scanning in progress.Please wait',style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold),),
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.all(20),
              behavior: SnackBarBehavior.floating,
              elevation: 30,
               action: SnackBarAction(
                label: 'Dismiss',
                disabledTextColor: Colors.white,
                textColor: Colors.yellow,
                onPressed: () {
                //Do whatever you want
                },
              ),
            ),
          );
          return false;
        }
      },
      child: Scaffold(
      appBar: AppBar(
        title: const Text('Connected Bluetooth Devices'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.purple),
                  ),
                  SizedBox(height: 20,),
                  Text('Scanning for Bluetooth Devices..',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
                  SizedBox(height: 5,),
                  Text('Please wait a moment..!')               
          ],
        ),
      )
      
    )
    );
  }
  
  void scanFunction() {
    Timer(const Duration(seconds: 10), () { 
      checkBluetoothStatus(context);
       allowNavigation = true;
        NavigatorState navigator = Navigator.of(context);
        navigator.popUntil((route) => route.isFirst);
        navigator.push(MaterialPageRoute(builder: (context) => const BlutoothMeasurePage()));
       //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>const BlutoothMeasurePage()));
    });
  }
}
Future<void> checkBluetoothStatus(context) async {
  
  bool isOn = await FlutterBluePlus.instance.isOn;
 
  if (isOn) {
    print('Bluetooth is on');
    getConnectionInfo();
  } else {
    showAlertDialog(context);
  }


}

Future<void> getConnectionInfo() async {
List<BluetoothDevice> connectedDevices = [];
connectedDevices = await FlutterBluePlus.instance.connectedDevices;
print(connectedDevices.isNotEmpty);
try{
if (connectedDevices.isNotEmpty) {
  print('Connected device: ');
  print('Connected devices: ${connectedDevices.length}');
  for (BluetoothDevice device in connectedDevices) {
    print(connectedDevices);
    print('Device name: ${device.name}');
    print('Device ID: ${device.id}');
    print('Device type: ${device.type}');
    DeviceIdentifier deviceId = device.id;
    String deviceUuid = deviceId.toString();
    print('Device UUID: $deviceUuid');

    if(deviceUuid.toString() == 'C0:00:00:00:01:DE'){
        mydvid=1;
        print('MyDevice');
        List<BluetoothService> services = await device.discoverServices();
        BluetoothCharacteristic spo2Characteristic;
        for (BluetoothService service in services) {
            print('Inside service');
            for (BluetoothService service in services) {
            if (service.uuid.toString() == dataStore.spo2ServiceId) {
            print('SPO2 service found!');
            for (BluetoothCharacteristic characteristic in service.characteristics) {
              if (characteristic.uuid.toString() == dataStore.spo2CharacteristicId) {
              print('SPO2 characteristic found!');
              spo2Characteristic = characteristic;
              await spo2Characteristic.setNotifyValue(true);
              
                  
              streamSubscription = spo2Characteristic.value.listen((value) {
                // Assuming that the device sends the data in the format <SPO2><PR><other data>
                //print('Values: $value');
                
                if (value.length >= 12 ) {
                  print('val: $value');
                  if(value[5] > 10 && value[6]>10 )
                  {
                  
                  int spo2 = value[5];
                  int pr = value[6];
                  if (counter <=100) {
                  spo2List.add(spo2);
                  }
                 // spo2List.add(spo2);
                  print('SPO2: $spo2, PR: $pr');
                  counter ++;
                  print('count = $counter');
                  //print(StackTrace.current);
                }
                }
                if (counter >100) {
                      print('exceded');
                      streamSubscription.cancel();
                      print('List :::$spo2List');
                      print('Length=${spo2List.length}');
                      
                      device.disconnect();
                      
                      //spo2Characteristic.setNotifyValue(false);
                      counter=0;
                      

                      
                      
                    }
                
                
                    //streamSubscription.cancel();
              });

              break;
            }
            else{
               print('SPO2 characteristic Not found!');
            }
          }
          break;
        }
      }
  
}
    }else{
        mydvid=2;
        //navigatorKey?.currentState?.pushReplacementNamed("btmeasure");
        break;
    }
    }

  }
else{
getConnection();
}
}on PlatformException catch (e) {
  print('Error: ${e.message}');
}
}
getConnection()  async{
  FlutterBluePlus flutterBluePlus = FlutterBluePlus.instance;
  Future<void> startScanning() async {
    print('Scanning for BLE devices...');
    flutterBluePlus.startScan(timeout:const Duration(seconds: 10));
    // Listen to scan results
    //print(flutterBluePlus.scanResults);
    var subscription = flutterBluePlus.scanResults.listen((results)  {
    //print('Result:$results');
    // do something with scan results
      for (ScanResult r in results) {
       print('${r.device.name} found! rssi: ${r.rssi} Id: ${r.device.id}');
       if(r.device.id.toString() == 'C0:00:00:00:01:DE' ){
           mydvid=1;
          flutterBluePlus.stopScan();
           r.device.connect().then((_) async {
          
  //Timer.periodic(Duration(minutes: 3), (timer) async {

  List<BluetoothService> services = await  r.device.discoverServices();
  BluetoothCharacteristic spo2Characteristic;
  try{
    for (BluetoothService service in services) {
      mydvid=1;
        if (service.uuid.toString() == dataStore.spo2ServiceId) {
          print('SPO2 service found!');
          for (BluetoothCharacteristic characteristic in service.characteristics) {
            if (characteristic.uuid.toString() == dataStore.spo2CharacteristicId) {
              print('SPO2 characteristic found!');
              spo2Characteristic = characteristic;
              await spo2Characteristic.setNotifyValue(true);
        
              streamSubscription = spo2Characteristic.value.listen((value) {
                // Assuming that the device sends the data in the format <SPO2><PR><other data>
                //print('Values: $value');
                
                if (value.length >= 12 ) {
                  if(value[5] > 10 && value[6] > 10 ){
                   print('val: $value');
                  int spo2 = value[5];
                  int pr = value[6];
                  if (counter <=100) {
                  spo2List.add(spo2);
                  }
                 // spo2List.add(spo2);
                  print('SPO2: $spo2, PR: $pr');
                  counter ++;
                  print('count = $counter');
                  //print(StackTrace.current);
                }
                if (counter > 100) {
                      print('exceded');
                      streamSubscription.cancel();
                      print('List :::$spo2List');
                      print('Length=${spo2List.length}');
                      r.device.disconnect();
                      //spo2Characteristic.setNotifyValue(true);
                      counter=0;
                      
                      
                    }
                
                
                  }  //streamSubscription.cancel();
              });
              
              break;
            }
          }
          break;
        }
}
  }on PlatformException catch (e) {
                print('Error: ${e.message}');
              }
 });
          //});
           
          print('connected to device');  
          break;
        }else{
          mydvid=0;
          //navigatorKey?.currentState?.pushReplacementNamed("btmeasure");
        }
    }
 
      
  
});
 flutterBluePlus.stopScan();
}
// Start scanning for BLE devices
startScanning();

}
//  turn on bt
showAlertDialog(context) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child:const Text("Cancel"),
    onPressed:  () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>const SpoGraphscreen()));
    },
  );
  
  Widget continueButton = TextButton(
    child:const Text("Continue"),
    onPressed:  () async{
      FlutterBluePlus.instance.turnOn();
      Navigator.pop(context);
      Timer(const Duration(seconds:5),(){
        getConnection();
     });
      ScaffoldMessenger.of(context).showSnackBar (const SnackBar(content: Text('Turned on')));
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title:const Text("Alert"),
    content: const Text("Bluetooth is currently turned off. Please click continue to turn on your device's bluetooth to continue."),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

// add data manually if mydvid==0
showAlertDialogofBt(BuildContext context) {
//   set up the buttons
  // Widget cancelButton = TextButton(
  //   child:const Text("Add Data Manually"),
  //   onPressed:  () {
  //     NavigatorState navigator = Navigator.of(context);
  //     navigator.popUntil((route) => route.isFirst);
  //     navigator.push(MaterialPageRoute(builder: (context) => const SpoGraphscreen()));
      
  //   },
  // );
  // Widget continueButton = TextButton(
  //   child:const Text("Scan Again"),
  //   onPressed:  () {
  //    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>const ConnectedBluetoothDevicesPage()));
  //   },
  // );
  // print(mydvid);
  // set up the AlertDialog
  AlertDialog alert = const AlertDialog(
    title: Text("Alert"),
    content:  Text("Device Unavailable.\nPlease scan again or add data manually"),
    // actions: [
    //   cancelButton,
    //   continueButton,
    // ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return alert;
    },
  );
}

//connected to another device mydvid=2
showAlertDialogforcoonect(BuildContext context) {
//   set up the buttons
  Widget cancelButton = TextButton(
    child:const Text("Cancel"),
    onPressed:  () {
      NavigatorState navigator = Navigator.of(context);
      navigator.popUntil((route) => route.isFirst);
      navigator.push(MaterialPageRoute(builder: (context) => const SpoGraphscreen()));
    },
  );
  Widget continueButton = TextButton(
    child:const Text("Settings"),
    onPressed:  () {
    Navigator.of(context).pop();
    AppSettings.openBluetoothSettings();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>const SpoGraphscreen()));
    },
  );

  // set up the AlertDialog
  AlertDialog alert = const AlertDialog(
    title: Text("Alert"),
    content:  Text("Connected with another  device.Please disconnect and try again"),
    // actions: [
    //   cancelButton,
    //   continueButton,
    // ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return WillPopScope(
      onWillPop: () async {
        NavigatorState navigator = Navigator.of(context);
        navigator.popUntil((route) => route.isFirst);
        navigator.push(MaterialPageRoute(builder: (context) => const SpoGraphscreen()));
        return false;
      }, child: alert,
  );
    }
  );

}




class BlutoothMeasurePage extends StatefulWidget {

  const BlutoothMeasurePage({super.key});

  @override
  State<BlutoothMeasurePage> createState()=>_BlutoothMeasurePagePageState();
 
}


class _BlutoothMeasurePagePageState
    extends State<BlutoothMeasurePage> with API {
  String title='Device Unavailable';
  String msg='Oops! Device is not available';
  List<BluetoothDevice> connectedDevicesList = <BluetoothDevice>[];

  @override
void didChangeDependencies() {
  super.didChangeDependencies();
   Future.delayed(Duration.zero, () {
   popupbox();
  });
}

  @override
  void initState() {
    super.initState();
     //popupbox();
    showspo2();
  //    Future.delayed(const Duration(seconds: 5), () {
   
  // });
  }
  var avg=true;
  @override
  Widget build(BuildContext context) {
    
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
                Text(msg),
            ],
          ),
        )
        
      ),
    );
  }
  
  void popupbox() {
    if(mydvid == 2){
     showAlertDialogforcoonect(context);
    }else if(mydvid== 0){
      showAlertDialogofBt(context);
  }else{
    print('Id Myid:$mydvid');
  }
}

  void showspo2() {
    try{
      print('Last List Length ${spo2List.last}');
    } catch (e) {
    spo2List.add(0);
}
if(spo2List.last != 0){
  setState(() {
    title='Oxygen Saturation Level';
    msg='Your SpO2 Level Is: ${spo2List.last}';
  });
  navigateTo();
}else{
    navigateToPg();
}    
  }
  
  void navigateTo() async{
    int d=int.parse(spo2List.last.toString());
    addRecord(reading: d, vitalid: 1);
    spo2List=[];
    await Future.delayed(const Duration(seconds: 3),(){
      navigatorKey?.currentState?.pushReplacementNamed("spgraph");
     });
    
    //navigateToNextScreen(context);
  }
  void navigateToPg() async{
    spo2List=[];
    await Future.delayed(const Duration(seconds: 3),(){
      navigatorKey?.currentState?.pushReplacementNamed("spgraph");
     });
    //navigateToNextScreen(context);
  }
  
//   void navigateToNextScreen(context) async{
//     await Future.delayed(const Duration(seconds: 1),(){
      
//     });
 
//  Navigator.pushReplacement(
//     context,
//     MaterialPageRoute(
//       builder: (BuildContext context) => const SpoGraphscreen(),
//     ),
//   );
//   }
}