
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';


import '../widgets/progressindicator.dart';
import 'package:healthapp/API/apicalls.dart';
import 'package:healthapp/API/model.dart';
import 'package:healthapp/core/navigator.dart';
import 'package:healthapp/screens/bpgraph.dart';
import 'package:healthapp/screens/spgraph.dart';
import 'dart:core';
import 'package:app_settings/app_settings.dart';
DataStore dataStore=DataStore();
int mydvid=0;
 List <int> spo2List =[];
 late StreamSubscription<List<int>> streamSubscription;
class ConnectedBpBluetoothDevicesPage extends StatefulWidget  {

  const ConnectedBpBluetoothDevicesPage({super.key});

  @override
  State<ConnectedBpBluetoothDevicesPage> createState()=>_ConnectedBpBluetoothDevicesPageState();
 
}


class _ConnectedBpBluetoothDevicesPageState extends State<ConnectedBpBluetoothDevicesPage> {
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
            Progressindicator(),
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
        navigator.push(MaterialPageRoute(builder: (context) => const BPBlutoothMeasurePage()));
       //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>const BPBlutoothMeasurePage()));
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

    if(deviceUuid.toString() == '46:F8:00:00:FF:FF'){
        mydvid=1;
        print('MyDevice');
        List<BluetoothService> services = await device.discoverServices();
        BluetoothCharacteristic spo2Characteristic;
        for (BluetoothService service in services) {
            print('Inside service');
            for (BluetoothService service in services) {
            if (service.uuid.toString() == dataStore.bpServiceId) {
            print('BP service found!');
            for (BluetoothCharacteristic characteristic in service.characteristics) {
              if ('0x${characteristic.uuid.toString().toUpperCase().substring(4,8)}' == dataStore.bpCharacteristicId) {
              print('BP characteristic found!');
               characteristic.write([0x45],withoutResponse: true);
              spo2Characteristic = characteristic;
              await spo2Characteristic.setNotifyValue(true);
              
                  
              streamSubscription = spo2Characteristic.value.listen((value) {
                // Assuming that the device sends the data in the format <SPO2><PR><other data>
                print('Values: $value');                 
                device.disconnect();
   //streamSubscription.cancel();
              });

              break;
            }
            else{
               print('BP characteristic Not found!');
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
       if(r.device.id.toString() == '46:F8:00:00:FF:FF' ){
           mydvid=1;
          flutterBluePlus.stopScan();
           r.device.connect().then((_) async {
          
  //Timer.periodic(Duration(minutes: 3), (timer) async {

  List<BluetoothService> services = await  r.device.discoverServices();
  BluetoothCharacteristic spo2Characteristic;
  try{
    for (BluetoothService service in services) {
      mydvid=1;
        if (service.uuid.toString() == dataStore.bpServiceId) {
          print('BP service found!');
          for (BluetoothCharacteristic characteristic in service.characteristics) {
            if ('0x${characteristic.uuid.toString().toUpperCase().substring(4,8)}' == dataStore.bpCharacteristicId) {
              print('BP characteristic found!');
              characteristic.write([0x45],withoutResponse: true);
              spo2Characteristic = characteristic;
              await spo2Characteristic.setNotifyValue(true);
        
              streamSubscription = spo2Characteristic.value.listen((value) {
                // Assuming that the device sends the data in the format <SPO2><PR><other data>
                print('Values: $value');
                         
                   //streamSubscription.cancel();
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
  //    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>const ConnectedBpBluetoothDevicesPage()));
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
      navigator.push(MaterialPageRoute(builder: (context) => const BPScreen()));
    },
  );
  Widget continueButton = TextButton(
    child:const Text("Settings"),
    onPressed:  () {
    Navigator.of(context).pop();
    AppSettings.openBluetoothSettings();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>const BPScreen()));
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
        navigator.push(MaterialPageRoute(builder: (context) => const BPScreen()));
        return false;
      }, child: alert,
  );
    }
  );

}




class BPBlutoothMeasurePage extends StatefulWidget {

  const BPBlutoothMeasurePage({super.key});

  @override
  State<BPBlutoothMeasurePage> createState()=>_BPBlutoothMeasurePagePageState();
 
}


class _BPBlutoothMeasurePagePageState
    extends State<BPBlutoothMeasurePage> with API {
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
      navigatorKey?.currentState?.pushReplacementNamed("bpgraph");
     });
    
    //navigateToNextScreen(context);
  }
  void navigateToPg() async{
    spo2List=[];
    await Future.delayed(const Duration(seconds: 3),(){
      navigatorKey?.currentState?.pushReplacementNamed("bpgraph");
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

















// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// //import 'package:healthapp/constants/divider.dart';
// import 'package:healthapp/screens/spgraph.dart';
// import 'dart:core';
// late StreamSubscription<List<int>> streamSubscription;
// class ConnectedBpBluetoothDevicesPage extends StatefulWidget {

//   const ConnectedBpBluetoothDevicesPage({super.key});

//   @override
//   State<ConnectedBpBluetoothDevicesPage> createState()=>_ConnectedBpBluetoothDevicesPageState();
 
// }


// class _ConnectedBpBluetoothDevicesPageState
//     extends State<ConnectedBpBluetoothDevicesPage> {
//   bool allowNavigation = false;
//   List<BluetoothDevice> connectedDevicesList = <BluetoothDevice>[];

//   @override
//   void initState() {
//     super.initState();
//     checkBluetoothStatus(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     scanFunction();
//     return WillPopScope(
//       onWillPop: () async {
//         if (allowNavigation) {
//           return true;
//         } else {
//           // Show snackbar to indicate back navigation is disabled
//           ScaffoldMessenger.of(context).showSnackBar(
//                SnackBar(
//               content: const Text('Scanning in progress.Please wait',style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold),),
//               backgroundColor: Colors.blue,
//               padding: const EdgeInsets.all(20),
//               behavior: SnackBarBehavior.floating,
//               elevation: 30,
//                action: SnackBarAction(
//                 label: 'Dismiss',
//                 disabledTextColor: Colors.white,
//                 textColor: Colors.yellow,
//                 onPressed: () {
//                 //Do whatever you want
//                 },
//               ),
//             ),
//           );
//           return false;
//         }
//       },
//       child: Scaffold(
//       appBar: AppBar(
//         title: const Text('Connected Bluetooth Devices'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: const [
//             CircularProgressIndicator(
//               valueColor: AlwaysStoppedAnimation<Color>(
//                   Colors.purple),
//                   ),
//                   SizedBox(height: 20,),
//                   Text('Scanning for Bluetooth Devices..',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
//                   SizedBox(height: 5,),
//                   Text('Please wait a moment..!')
//           ],
//         ),
//       )
      
//     )
//     );
//   }
  
//   void scanFunction() {
//     Timer(const Duration(seconds: 10), () { 
//       checkBluetoothStatus(context);
//        allowNavigation = true;
//       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>const BlutoothBpMeasurePage()));
//     });
//   }
// }

// getConnection()  {
//   FlutterBluePlus flutterBluePlus = FlutterBluePlus.instance;
//   Future<void> startScanning() async {
//     print('Scanning for BLE devices...');
//       flutterBluePlus.startScan(timeout:const Duration(seconds: 10));
// // Listen to scan results
// print(flutterBluePlus.scanResults);
// var subscription = flutterBluePlus.scanResults.listen((results)  {
//     print('Result:$results');
//     // do something with scan results
//     //46:F8:00:00:FF:FF
//     for (ScanResult r in results) {
//        print('${r.device.name} found! rssi: ${r.rssi} Id: ${r.device.id}');
//        if(r.device.id.toString() == '46:F8:00:00:FF:FF' ){
//          // mydvid=1;
//           flutterBluePlus.stopScan();
//            r.device.connect().then((_) async {
          
//   //Timer.periodic(Duration(minutes: 3), (timer) async {

//   List<BluetoothService> services = await  r.device.discoverServices();
//   BluetoothCharacteristic spo2Characteristic;
//   try{
// for (BluetoothService service in services) {
//   print('in1');
//   //print(service);
// //   
// for (BluetoothService service in services) {
//         if (service.uuid.toString() == dataStore.bpServiceId) {
//           print('SPO2 service found!');
//           for (BluetoothCharacteristic characteristic in service.characteristics) {


//   //if(('0x${characteristic.uuid.toString().toUpperCase().substring(4,8)}')==dataStore.bpCharacteristicId)


//             if ('0x${characteristic.uuid.toString().toUpperCase().substring(4,8)}'== dataStore.bpCharacteristicId) {
//               print('SPO2 characteristic found!');
//               characteristic.write([0x45],withoutResponse: true);
//               spo2Characteristic = characteristic;
//               await spo2Characteristic.setNotifyValue(true);
        
//               streamSubscription = spo2Characteristic.value.listen((value) {
//                 // Assuming that the device sends the data in the format <SPO2><PR><other data>
//                 print('Values: $value');
//                 r.device.disconnect();
                
                
                
//                     //streamSubscription.cancel();
//               });
              
//               break;
//             }
//           }
//           break;
//         }
//       }
  
// }
//   }on PlatformException catch (e) {
//                 print('Error: ${e.message}');
//               }
//  });
//           //});
           
//           print('connected to device');  
//           break;
//         }else{
//           //mydvid=0;
//           //navigatorKey?.currentState?.pushReplacementNamed("btmeasure");
//         }
//     }    
// });
//  flutterBluePlus.stopScan();
// }


// // Start scanning for BLE devices
// startScanning();

// }

// Future<void> checkBluetoothStatus(context) async {
  
//   bool isOn = await FlutterBluePlus.instance.isOn;
 
//   if (isOn) {
//     print('Bluetooth is on');
//     getConnectionInfo();
//   } else {
//     showAlertDialog(context);
//   }


// }

// Future<void> getConnectionInfo() async {
// List<BluetoothDevice> connectedDevices = [];
// connectedDevices = await FlutterBluePlus.instance.connectedDevices;
// print(connectedDevices.isNotEmpty);
// try{
// if (connectedDevices.isNotEmpty) {
//   print('Connected devices: ');
//   print('Connected devices: ${connectedDevices.length}');
//   for (BluetoothDevice device in connectedDevices) {
//     print(connectedDevices);
//     print('Device name1: ${device.name}');
//     print('Device ID: ${device.id}');
//     print('Device type: ${device.type}');
//     DeviceIdentifier deviceId = device.id;
//     String deviceUuid = deviceId.toString();
//     print('Device UUID: $deviceUuid');
//     //device.connect(); // -- exception
//   //Timer.periodic(Duration(seconds: 10), (timer) async {
  
//   //List<BluetoothService> services = await device.discoverServices();
//   //BluetoothCharacteristic bpCharacteristic;
//   if(deviceUuid.toString() == '46:F8:00:00:FF:FF'){
//     //mydvid=1;
//     print('MyDevice is Ready');
//     List<BluetoothService> services = await device.discoverServices();
//     BluetoothCharacteristic spo2Characteristic;
//     for (BluetoothService service in services) {
//             print('Inside service');
//             if (service.uuid.toString() == dataStore.bpServiceId) {
//             print('BP service found!');
//             for (BluetoothCharacteristic characteristic in service.characteristics) {
              
//               if (characteristic.uuid.toString().substring(4,8) == dataStore.bpCharacteristicId) {
//               print('BP characteristic found!');
//               spo2Characteristic = characteristic;
//               await spo2Characteristic.setNotifyValue(true);
//               streamSubscription = spo2Characteristic.value.listen((value) {
//                 // Assuming that the device sends the data in the format <SPO2><PR><other data>
//                 print('Value: $value');
//                 // int systolic = value[1] << 8 | value[0];
//                 // int diastolic = value[3] << 8 | value[2];
//                 // print("Systolic: $systolic, Diastolic: $diastolic");
//                 device.disconnect();
//                     //streamSubscription.cancel();
//               });

//               break;
//             }
//             else{
//                print('BP characteristic Not found!');
//             }
//           }
//           break;
//         }
      
  
// }
//   }


//     }

//   }
// else{
// getConnection();
// }
// }on PlatformException catch (e) {
//   print('Error: ${e.message}');
// }
// }
// showAlertDialog(BuildContext context) {

//   // set up the buttons
//   Widget cancelButton = TextButton(
//     child:const Text("Cancel"),
//     onPressed:  () {
//        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const SpoGraphscreen()));
//     },
//   );
//   Widget continueButton = TextButton(
//     child:const Text("Continue"),
//     onPressed:  () async{
//       FlutterBluePlus.instance.turnOn();
//       Navigator.pop(context);
//       Timer(const Duration(seconds:5),(){
//         getConnection();
//       });
//       ScaffoldMessenger.of(context).showSnackBar (const SnackBar(content: Text('Turned on')));
     
//     },
//   );

//   // set up the AlertDialog
//   AlertDialog alert = AlertDialog(
//     title:const Text("Alert"),
//     content: const Text("Bluetooth is currently turned off. Please click continue to turn on your device's bluetooth to continue."),
//     actions: [
//       cancelButton,
//       continueButton,
//     ],
//   );

//   // show the dialog
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return alert;
//     },
//   );
// }

// class BlutoothBpMeasurePage extends StatefulWidget {

//   const BlutoothBpMeasurePage({super.key});

//   @override
//   State<BlutoothBpMeasurePage> createState()=>_BlutoothBpMeasurePagePageState();
 
// }


// class _BlutoothBpMeasurePagePageState
//     extends State<BlutoothBpMeasurePage> {
  
//   List<BluetoothDevice> connectedDevicesList = <BluetoothDevice>[];

//   @override
//   void initState() {
//     super.initState();
    
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Connected Bluetooth Devices'),
//       ),
//       body: Center(
//         child: Column(
//           children: const [
//               Text('This page is under development.'),
//           ],
//         ),
//       )
      
//     );
//   }
// }



// // import 'dart:async';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// // //import 'package:healthapp/constants/divider.dart';
// // import 'package:healthapp/screens/spgraph.dart';
// // import 'dart:core';

// // class ConnectedBpBluetoothDevicesPage extends StatefulWidget {

// //   const ConnectedBpBluetoothDevicesPage({super.key});

// //   @override
// //   State<ConnectedBpBluetoothDevicesPage> createState()=>_ConnectedBpBluetoothDevicesPageState();
 
// // }


// // class _ConnectedBpBluetoothDevicesPageState
// //     extends State<ConnectedBpBluetoothDevicesPage> {
// //   bool allowNavigation = false;
// //   List<BluetoothDevice> connectedDevicesList = <BluetoothDevice>[];

// //   @override
// //   void initState() {
// //     super.initState();
// //     checkBluetoothStatus(context);
    
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     scanFunction();
// //     return WillPopScope(
// //       onWillPop: () async {
// //         if (allowNavigation) {
// //           return true;
// //         } else {
// //           // Show snackbar to indicate back navigation is disabled
// //           ScaffoldMessenger.of(context).showSnackBar(
// //               const SnackBar(
// //               content: Text('Scanning in progress.Please wait'),
// //               backgroundColor: Colors.blue,
// //               padding: EdgeInsets.all(20),
// //               behavior: SnackBarBehavior.floating,
// //               elevation: 30,
// //               //  action: SnackBarAction(
// //               //   label: 'Dismiss',
// //               //   disabledTextColor: Colors.white,
// //               //   textColor: Colors.yellow,
// //               //   onPressed: () {
// //               //   //Do whatever you want
// //               //   },
// //               // ),
// //             ),
// //           );
// //           return false;
// //         }
// //       },
// //       child: Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Connected Bluetooth Devices'),
// //       ),
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: const [
// //             CircularProgressIndicator(
// //               valueColor: AlwaysStoppedAnimation<Color>(
// //                   Colors.purple),
// //                   ),
// //                   SizedBox(height: 20,),
// //                   Text('Scanning for Bluetooth Devices..',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
// //                   SizedBox(height: 5,),
// //                   Text('Please wait a moment..!')
// //           ],
// //         ),
// //       )
      
// //     )
// //     );
// //   }
  
// //   void scanFunction() {
// //     Timer(const Duration(seconds: 10), () { 
// //       checkBluetoothStatus(context);
// //        allowNavigation = true;
// //       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>const BlutoothBpMeasurePage()));
// //     });
// //   }
// // }

// // getConnection()  {
// //   FlutterBluePlus flutterBluePlus = FlutterBluePlus.instance;
// //   Future<void> startScanning() async {
// //     print('Scanning for BLE BP devices...');
// //       flutterBluePlus.startScan(timeout:const Duration(seconds: 10));
// //       // Listen to scan results
// //       print(flutterBluePlus.scanResults);
// //       var subscription = flutterBluePlus.scanResults.listen((results) {
// //       //print('Result:::$results');
// //       // do something with scan results
// //        outerloop:
// //         for (ScanResult r in results) {
// //           print('${r.device.name} found! rssi: ${r.rssi} Id: ${r.device.id}');
// //           if(r.device.id.toString() == '46:F8:00:00:FF:FF' ) {
// //             print('found');
// //           flutterBluePlus.stopScan();
// //           //r.device.connect();
// //           //break outerloop;
// //           //print('connected to device');
// //           // flutterBluePlus.stopScan();
// //             r.device.connect().then((_) {
// //             print('connected to device');
// //             print('services');
// //             r.device.discoverServices().then((services) {
// //             print(services);
           
     
// //             });  
// //           }); 

// //            break outerloop;

          
// //         }
// //       }
// //     });
// //  flutterBluePlus.stopScan();
// // }


// // // Start scanning for BLE devices
// // startScanning();

// // }

// // Future<void> checkBluetoothStatus(context) async {
  
// //   bool isOn = await FlutterBluePlus.instance.isOn;
 
// //   if (isOn) {
// //     print('Bluetooth is on');
// //     getConnectionInfo();
// //   } else {
// //     showAlertDialog(context);
// //   }


// // }

// // Future<void> getConnectionInfo() async {
// // List<BluetoothDevice> connectedDevices = [];
// // connectedDevices = await FlutterBluePlus.instance.connectedDevices;
// // print(connectedDevices.isNotEmpty);
// // if (connectedDevices.isNotEmpty) {
// //   print('if Connected : ');
// //   print('Connected devices : ${connectedDevices.length}');
// //   for (BluetoothDevice device in connectedDevices) {
// //     print(connectedDevices);
// //     print('Device name: ${device.name}');
// //     print('Device ID: ${device.id}');
// //     print('Device type: ${device.type}');
// //     DeviceIdentifier deviceId = device.id;
// //     String deviceUuid = deviceId.toString();
// //     print('Device UUID: $deviceUuid');
// //      print('calc');
// //      if (device.id.toString() == '46:F8:00:00:FF:FF') {
// //       print('Found device');
// //       print(device);

// //     device.discoverServices().then((services) {
// //       services.forEach((service) {
// //         if (service.uuid.toString() == '14839ac4-7d7e-415c-9a42-167340cf2339') {
          
// //           service.characteristics.forEach((characteristic) {
// //             if ('0x${characteristic.uuid.toString().toUpperCase().substring(4, 8)}' == '0x2A37') {
// //               print('Found characteristic');
// //               // Subscribe to notifications for the blood pressure measurement
// //               characteristic.setNotifyValue(true);

// //               // Listen to the characteristic value changes
// //               characteristic.value.listen((value) {
// //               // Process blood pressure measurement data
// //               List<int> data = value;
// //               print('Blood pressure measurement data: $data');
// //             });
// //           }
// //         });
// //       }
// //     });
// //   });
// // }
// // //      Stream<List<BluetoothService>> services =  device.services;
// // //      services.listen((List<BluetoothService> servicesList) {
// // //   // Print the UUID of each service
// // //   for (BluetoothService service in servicesList) {
// // //     print('Service UUID: ${service.uuid}');
// // //   }2h
// // // });
 
// //     }
// //   }
// // else{
// // getConnection();
// // }
// // }
// // showAlertDialog(BuildContext context) {

// //   // set up the buttons
// //   Widget cancelButton = TextButton(
// //     child:const Text("Cancel"),
// //     onPressed:  () {
// //        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const SpoGraphscreen()));
// //     },
// //   );
// //   Widget continueButton = TextButton(
// //     child:const Text("Continue"),
// //     onPressed:  () async{
// //       FlutterBluePlus.instance.turnOn();
// //       Navigator.pop(context);
// //       Timer(const Duration(seconds:5),(){
// //         getConnection();
// //       });
// //       ScaffoldMessenger.of(context).showSnackBar (const SnackBar(content: Text('Turned on')));
     
// //     },
// //   );

// //   // set up the AlertDialog
// //   AlertDialog alert = AlertDialog(
// //     title:const Text("Alert"),
// //     content: const Text("Bluetooth is currently turned off. Please click continue to turn on your device's bluetooth to continue."),
// //     actions: [
// //       cancelButton,
// //       continueButton,
// //     ],
// //   );

// //   // show the dialog
// //   showDialog(
// //     context: context,
// //     builder: (BuildContext context) {
// //       return alert;
// //     },
// //   );
// // }

// // class BlutoothBpMeasurePage extends StatefulWidget {

// //   const BlutoothBpMeasurePage({super.key});

// //   @override
// //   State<BlutoothBpMeasurePage> createState()=>_BlutoothBpMeasurePagePageState();
 
// // }


// // class _BlutoothBpMeasurePagePageState
// //     extends State<BlutoothBpMeasurePage> {
  
// //   List<BluetoothDevice> connectedDevicesList = <BluetoothDevice>[];

// //   @override
// //   void initState() {
// //     super.initState();
// //     getMeasureFromDevice();
    
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Connected Bluetooth Devices'),
// //       ),
// //       body: Center(
// //         child: Column(
// //           children: const [
// //               Text('This page is under development.'),
// //           ],
// //         ),
// //       )
      
// //     );
// //   }
  
// //   void getMeasureFromDevice() {
    
       
     
// //   }
  

// // }



// class BPMonitor extends StatefulWidget {
//   const BPMonitor({super.key});

  

//   @override
//   _BPMonitorState createState() => _BPMonitorState();
// }

// class _BPMonitorState extends State<BPMonitor> {
//   late BluetoothDevice device;
//   late List<BluetoothService> services;
//   late BluetoothCharacteristic bloodPressureCharacteristic;
//   late StreamSubscription<List<int>> bloodPressureStream;

//   static const String serviceId = "14839ac4-7d7e-415c-9a42-167340cf2339";
//   static const String characteristicId = "2A37";

//   void _startScanning() {
//     FlutterBluePlus.instance.startScan(timeout: Duration(seconds: 4));
//   }

//    Future<void> _connectToDevice() async {
//   final String deviceId = "46:F8:00:00:FF:FF";
//   late StreamSubscription<ScanResult> scanSubscription;
//   scanSubscription = FlutterBluePlus.instance.scan(timeout: Duration(seconds: 4)).listen((scanResult) async {
//     if (scanResult.device.id.toString() == deviceId) {
//       await scanSubscription.cancel();
//       await scanResult.device.connect();
//       device = scanResult.device;
//     }
//   });
// }

//   Future<void> _discoverServices() async {
//     services = await device.discoverServices();
//     BluetoothService bloodPressureService = services
//         .firstWhere((service) => service.uuid.toString() == serviceId);
//     bloodPressureCharacteristic = bloodPressureService.characteristics
//         .firstWhere((characteristic) => characteristic.uuid.toString() == characteristicId);
//   }

//   void _startBloodPressureStream() {
//     bloodPressureCharacteristic.setNotifyValue(true);
//     bloodPressureStream = bloodPressureCharacteristic.value.listen((value) {
//       // Parse the blood pressure data from the value list here
//       // For example, you could parse the systolic and diastolic pressure values like this:
//       int systolic = value[1] << 8 | value[0];
//       int diastolic = value[3] << 8 | value[2];
//       print("Systolic: $systolic, Diastolic: $diastolic");
//     });
//   }

//   void _stopBloodPressureStream() {
//     bloodPressureCharacteristic.setNotifyValue(false);
//     bloodPressureStream.cancel();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('BPBp'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             ElevatedButton(
//               onPressed: _startScanning,
//               child: Text("Start Scanning"),
//             ),
//             ElevatedButton(
//               onPressed: _connectToDevice,
//               child: Text("Connect to Device"),
//             ),
//             ElevatedButton(
//               onPressed: _discoverServices,
//               child: Text("Discover Services"),
//             ),
//             ElevatedButton(
//               onPressed: _startBloodPressureStream,
//               child: Text("Start Blood Pressure Stream"),
//             ),
//             ElevatedButton(
//               onPressed: _stopBloodPressureStream,
//               child: Text("Stop Blood Pressure Stream"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _stopBloodPressureStream();
//     super.dispose();
//   }
// }