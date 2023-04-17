import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
//import 'package:healthapp/constants/divider.dart';
import 'package:healthapp/screens/spgraph.dart';
import 'dart:core';

class ConnectedBpBluetoothDevicesPage extends StatefulWidget {

  const ConnectedBpBluetoothDevicesPage({super.key});

  @override
  State<ConnectedBpBluetoothDevicesPage> createState()=>_ConnectedBpBluetoothDevicesPageState();
 
}


class _ConnectedBpBluetoothDevicesPageState
    extends State<ConnectedBpBluetoothDevicesPage> {
  bool allowNavigation = false;
  List<BluetoothDevice> connectedDevicesList = <BluetoothDevice>[];

  @override
  void initState() {
    super.initState();
    checkBluetoothStatus(context);
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
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>const BlutoothBpMeasurePage()));
    });
  }
}

getConnection()  {
  FlutterBluePlus flutterBluePlus = FlutterBluePlus.instance;
  Future<void> startScanning() async {
    print('Scanning for BLE devices...');
      flutterBluePlus.startScan(timeout:const Duration(seconds: 10));
// Listen to scan results
print(flutterBluePlus.scanResults);
var subscription = flutterBluePlus.scanResults.listen((results)  {
    print('Result:$results');
    // do something with scan results
        for (ScanResult r in results) {
        print('${r.device.name} found! rssi: ${r.rssi} Id: ${r.device.id}');
        if(r.device.id.toString() == '46:F8:00:00:FF:FF' ){
          flutterBluePlus.stopScan();
           r.device.connect();//.then((_) async {
//           final String bp2ServiceId ='6e400001-b5a3-f393-e0a9-e50e24dcca9e';
//           final String bpCharacteristicId ='6e400003-b5a3-f393-e0a9-e50e24dcca9e';
//           List<BluetoothService> services = await r.device.discoverServices();
//           BluetoothCharacteristic bpCharacteristic;
// for (BluetoothService service in services) {
//   print('in1');
//   print(services);
//   // if (service.uuid == Guid(bp2ServiceId)) {
//   //   print('in2');
//   //   // for (BluetoothCharacteristic characteristic in service.characteristics) {
//   //   //    print(service.characteristics);
//   //   //   if (characteristic.uuid ==  Guid(bpCharacteristicId)) {
//   //   //     print('in3');
//   //   //     bpCharacteristic = characteristic;
//   //   //     await bpCharacteristic.setNotifyValue(true);
//   //   //     break;
//   //   //   }
//   //   // }
//   // }
  
// }

//           });
           
          print('connected to device');  
        }
    }
});
 flutterBluePlus.stopScan();
}


// Start scanning for BLE devices
startScanning();

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
  print('Connected devices: ');
  print('Connected devices: ${connectedDevices.length}');
  for (BluetoothDevice device in connectedDevices) {
    print(connectedDevices);
    print('Device name: ${device.name}');
    print('Device ID: ${device.id}');
    print('Device type: ${device.type}');
    DeviceIdentifier deviceId = device.id;
    String deviceUuid = deviceId.toString();
    print('Device UUID: $deviceUuid');
    //device.connect(); // -- exception
    Timer.periodic(Duration(seconds: 30), (timer) async {
  final String bp2ServiceId ='14839ac4-7d7e-415c-9a42-167340cf2339';//'5833ff01-9b8b-5191-6142-22a4536ef123' ;//
  final String bpCharacteristicId ='0734594a-a8e7-4b1a-a6b1-cd5243059a57';//'8b00ace7-eb0b-49b0-bbe9-9aee0a26e1a3';//'6e400003-b5a3-f393-e0a9-e50e24dcca9e';
  List<BluetoothService> services = await device.discoverServices();
  BluetoothCharacteristic bpCharacteristic;
for (BluetoothService service in services) {
  print('in1');
  //print(service);
//   
for (BluetoothService service in services) {
        if (service.uuid.toString() == bp2ServiceId) {
          print('BP service found!');
          for (BluetoothCharacteristic characteristic in service.characteristics) {
            if (characteristic.uuid.toString() == bpCharacteristicId) {
              print('BP characteristic found!');
              bpCharacteristic = characteristic;
              await bpCharacteristic.setNotifyValue(true);
               for (BluetoothDescriptor descriptor in characteristic.descriptors) {
            if (descriptor.uuid.toString() == '00002902-0000-1000-8000-00805f9b34fb') {
              await descriptor.write([0x01, 0x00]);
              print('BP descriptor set!');
              break;
            }
          }
              bpCharacteristic.value.listen((value) {
                // Assuming that the device sends the data in the format <bp><PR><other data>
                print('Values BP: $value');
                // if (value.length >= 2) {
                //   int bp = value[5];
                //   int pr = value[6];
                //   print('bp: $bp, PR: $pr');
                  
                // }
              });
              break;
            }
          }
          break;
        }
      }
  
}
 });

    }

  }
else{
getConnection();
}
}on PlatformException catch (e) {
  print('Error: ${e.message}');
}
}
showAlertDialog(BuildContext context) {

  // set up the buttons
  Widget cancelButton = TextButton(
    child:const Text("Cancel"),
    onPressed:  () {
       Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const SpoGraphscreen()));
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

class BlutoothBpMeasurePage extends StatefulWidget {

  const BlutoothBpMeasurePage({super.key});

  @override
  State<BlutoothBpMeasurePage> createState()=>_BlutoothBpMeasurePagePageState();
 
}


class _BlutoothBpMeasurePagePageState
    extends State<BlutoothBpMeasurePage> {
  
  List<BluetoothDevice> connectedDevicesList = <BluetoothDevice>[];

  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connected Bluetooth Devices'),
      ),
      body: Center(
        child: Column(
          children: const [
              Text('This page is under development.'),
          ],
        ),
      )
      
    );
  }
}



// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// //import 'package:healthapp/constants/divider.dart';
// import 'package:healthapp/screens/spgraph.dart';
// import 'dart:core';

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
//               const SnackBar(
//               content: Text('Scanning in progress.Please wait'),
//               backgroundColor: Colors.blue,
//               padding: EdgeInsets.all(20),
//               behavior: SnackBarBehavior.floating,
//               elevation: 30,
//               //  action: SnackBarAction(
//               //   label: 'Dismiss',
//               //   disabledTextColor: Colors.white,
//               //   textColor: Colors.yellow,
//               //   onPressed: () {
//               //   //Do whatever you want
//               //   },
//               // ),
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
//     print('Scanning for BLE BP devices...');
//       flutterBluePlus.startScan(timeout:const Duration(seconds: 10));
//       // Listen to scan results
//       print(flutterBluePlus.scanResults);
//       var subscription = flutterBluePlus.scanResults.listen((results) {
//       //print('Result:::$results');
//       // do something with scan results
//        outerloop:
//         for (ScanResult r in results) {
//           print('${r.device.name} found! rssi: ${r.rssi} Id: ${r.device.id}');
//           if(r.device.id.toString() == '46:F8:00:00:FF:FF' ) {
//             print('found');
//           flutterBluePlus.stopScan();
//           //r.device.connect();
//           //break outerloop;
//           //print('connected to device');
//           // flutterBluePlus.stopScan();
//             r.device.connect().then((_) {
//             print('connected to device');
//             print('services');
//             r.device.discoverServices().then((services) {
//             print(services);
           
     
//             });  
//           }); 

//            break outerloop;

          
//         }
//       }
//     });
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
// if (connectedDevices.isNotEmpty) {
//   print('if Connected : ');
//   print('Connected devices : ${connectedDevices.length}');
//   for (BluetoothDevice device in connectedDevices) {
//     print(connectedDevices);
//     print('Device name: ${device.name}');
//     print('Device ID: ${device.id}');
//     print('Device type: ${device.type}');
//     DeviceIdentifier deviceId = device.id;
//     String deviceUuid = deviceId.toString();
//     print('Device UUID: $deviceUuid');
//      print('calc');
//      if (device.id.toString() == '46:F8:00:00:FF:FF') {
//       print('Found device');
//       print(device);

//     device.discoverServices().then((services) {
//       services.forEach((service) {
//         if (service.uuid.toString() == '14839ac4-7d7e-415c-9a42-167340cf2339') {
          
//           service.characteristics.forEach((characteristic) {
//             if ('0x${characteristic.uuid.toString().toUpperCase().substring(4, 8)}' == '0x2A37') {
//               print('Found characteristic');
//               // Subscribe to notifications for the blood pressure measurement
//               characteristic.setNotifyValue(true);

//               // Listen to the characteristic value changes
//               characteristic.value.listen((value) {
//               // Process blood pressure measurement data
//               List<int> data = value;
//               print('Blood pressure measurement data: $data');
//             });
//           }
//         });
//       }
//     });
//   });
// }
// //      Stream<List<BluetoothService>> services =  device.services;
// //      services.listen((List<BluetoothService> servicesList) {
// //   // Print the UUID of each service
// //   for (BluetoothService service in servicesList) {
// //     print('Service UUID: ${service.uuid}');
// //   }2h
// // });
 
//     }
//   }
// else{
// getConnection();
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
//     getMeasureFromDevice();
    
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
  
//   void getMeasureFromDevice() {
    
       
     
//   }
  

// }
