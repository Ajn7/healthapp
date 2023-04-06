import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:healthapp/screens/spgraph.dart';
import 'dart:core';

class ConnectedBluetoothDevicesPage extends StatefulWidget {

  const ConnectedBluetoothDevicesPage({super.key});

  @override
  State<ConnectedBluetoothDevicesPage> createState()=>_ConnectedBluetoothDevicesPageState();
 
}


class _ConnectedBluetoothDevicesPageState
    extends State<ConnectedBluetoothDevicesPage> {
  
  List<BluetoothDevice> connectedDevicesList = <BluetoothDevice>[];

  @override
  void initState() {
    super.initState();
    checkBluetoothStatus(context);
    
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

Future<void> getConnectedInfo() async {
List<BluetoothDevice> connectedDevices = [];
connectedDevices = await FlutterBluePlus.instance.connectedDevices;
print(connectedDevices.isNotEmpty);
print('111');
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
  }
 

} else {
  print('2222');
FlutterBluePlus flutterBluePlus = FlutterBluePlus.instance;

Guid deviceUuid = Guid('CB560009-DC49-0000-0000-000000000000'); // Replace with your device's UUID

// ...

flutterBluePlus.scanResults.listen((List<ScanResult> scanResults) async {
  for (ScanResult scanResult in scanResults) {
    print(scanResult);
    if (scanResult.device.id.toString() == deviceUuid.toString()) { // Check if the device's UUID matches
      await flutterBluePlus.stopScan();
      await scanResult.device.connect();
      print('connected to device ');
      break;
    }
  }
});

// Start scanning for Bluetooth devices
flutterBluePlus.startScan();
}

}

Future<void> checkBluetoothStatus(context) async {
  
  bool isOn = await FlutterBluePlus.instance.isOn;
 
  if (isOn) {
    print('Bluetooth is on');
    getConnectedInfo();
  } else {
    showAlertDialog(context);
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
      ScaffoldMessenger.of(context).showSnackBar (const SnackBar(content: Text('Turned on')));
      Navigator.pop(context);
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

