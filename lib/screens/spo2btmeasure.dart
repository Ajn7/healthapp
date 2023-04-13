import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:healthapp/screens/spgraph.dart';
import 'dart:core';
import 'package:app_settings/app_settings.dart';
var counter=0;
int mydvid=0;
class ConnectedBluetoothDevicesPage extends StatefulWidget {

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
       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>const BlutoothMeasurePage()));
    });
  }
}
Future<void> checkBluetoothStatus(context) async {
  
  bool isOn = await FlutterBluePlus.instance.isOn;
 
  if (isOn) {
    print('Bluetooth is on');
    getConnectionInfo(context);
  } else {
    showAlertDialog(context);
  }


}

Future<void> getConnectionInfo(context) async {
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

    if(deviceUuid.toString() == 'C0:00:00:00:01:DE'){
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
              late StreamSubscription<List<int>> streamSubscription;
                  int counter = 0;
              streamSubscription = spo2Characteristic.value.listen((value) {
                // Assuming that the device sends the data in the format <SPO2><PR><other data>
                //print('Values: $value');
                
                if (value.length >= 2 ) {
                  int spo2 = value[5];
                  int pr = value[6];
                  print('SPO2: $spo2, PR: $pr');
                  counter ++;
                  print('count = $counter');
                }
                if (counter >= 500) {
                      streamSubscription.cancel();
                      spo2Characteristic.setNotifyValue(false);
                    }
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
        mydvid=1;
    }
    //device.connect(); // -- exception

    //Timer.periodic(Duration(minutes: 1), (timer) async {

 //});

    }

  }
else{
getConnection(context);
}
}on PlatformException catch (e) {
  print('Error: ${e.message}');
}
}
getConnection(context)  {
  FlutterBluePlus flutterBluePlus = FlutterBluePlus.instance;
  Future<void> startScanning() async {
    print('Scanning for BLE devices...');
    flutterBluePlus.startScan(timeout:const Duration(seconds: 10));
    // Listen to scan results
    print(flutterBluePlus.scanResults);
    var subscription = flutterBluePlus.scanResults.listen((results)  {
    //print('Result:$results');
    // do something with scan results
      for (ScanResult r in results) {
       print('${r.device.name} found! rssi: ${r.rssi} Id: ${r.device.id}');
       if(r.device.id.toString() == 'C0:00:00:00:01:DE' ){
          mydvid=1;
          flutterBluePlus.stopScan();
           r.device.connect().then((_) async {
          
  Timer.periodic(Duration(minutes: 3), (timer) async {
  List<BluetoothService> services = await  r.device.discoverServices();
  BluetoothCharacteristic spo2Characteristic;
for (BluetoothService service in services) {
  print('in1');
  //print(service);
//   
for (BluetoothService service in services) {
        if (service.uuid.toString() == dataStore.spo2ServiceId) {
          print('SPO2 service found!');
          for (BluetoothCharacteristic characteristic in service.characteristics) {
            if (characteristic.uuid.toString() == dataStore.spo2CharacteristicId) {
              print('SPO2 characteristic found!');
              spo2Characteristic = characteristic;
              await spo2Characteristic.setNotifyValue(true);
              spo2Characteristic.value.listen((value) {
                // Assuming that the device sends the data in the format <SPO2><PR><other data>
                print('Values: $value');
                if (value.length >= 2) {
                  int spo2 = value[5];
                  int pr = value[6];
                  print('SPO2: $spo2, PR: $pr');
                  
                }
              });
              break;
            }
          }
          break;
        }
      }
  
}
 });
          });
           
          print('connected to device');  
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
        getConnection(context);
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
  Widget cancelButton = TextButton(
    child:const Text("Add Data Manually"),
    onPressed:  () {
      NavigatorState navigator = Navigator.of(context);
      navigator.popUntil((route) => route.isFirst);
      navigator.push(MaterialPageRoute(builder: (context) => const SpoGraphscreen()));
      //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>const SpoGraphscreen()));
    },
  );
  Widget continueButton = TextButton(
    child:const Text("Scan Again"),
    onPressed:  () {
     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>const ConnectedBluetoothDevicesPage()));
    },
  );
  print(mydvid);
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title:const Text("Alert"),
    content: const Text("Device's Unavailable."),
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

//connected to another device mydvid=1
showAlertDialogforcoonect(BuildContext context) {

  
//   set up the buttons
  Widget cancelButton = TextButton(
    child:const Text("Cancel"),
    onPressed:  () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>const SpoGraphscreen()));
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
  AlertDialog alert = AlertDialog(
    title:const Text("Alert"),
    content: const Text("Connected with another bluetooth device."),
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
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>const SpoGraphscreen()));
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
    extends State<BlutoothMeasurePage> {
  
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
    //showAlertDialogofBt(context);
  }
  var avg=true;
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
  
  void popupbox() {
    if(mydvid==1){
     showAlertDialogforcoonect(context);
    }else if(mydvid== 0){
      showAlertDialogofBt(context);
  }
}
}