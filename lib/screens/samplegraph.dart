// import 'package:flutter/material.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// class BluetoothPage extends StatefulWidget {
//   @override
//   _BluetoothPageState createState() => _BluetoothPageState();
// }

// class _BluetoothPageState extends State<BluetoothPage> {
//   FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
//   List<BluetoothDevice> devicesList = <BluetoothDevice>[];

//   @override
//   void initState() {
//     super.initState();
//     flutterBlue.connectedDevices
//         .asStream()
//         .listen((List<BluetoothDevice> devices) {
//       for (BluetoothDevice device in devices) {
//         if (!devicesList.contains(device)) {
//           setState(() {
//             devicesList.add(device);
//           });
//         }
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Available Bluetooth Devices'),
//       ),
//       body: ListView.builder(
//         itemCount: devicesList.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(devicesList[index].name == ''
//                 ? 'Unnamed Device'
//                 : devicesList[index].name),
//             subtitle: Text(devicesList[index].id.toString()),
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class ConnectedBluetoothDevicesPage extends StatefulWidget {
  @override
  _ConnectedBluetoothDevicesPageState createState() =>
      _ConnectedBluetoothDevicesPageState();
}

class _ConnectedBluetoothDevicesPageState
    extends State<ConnectedBluetoothDevicesPage> {
  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
  List<BluetoothDevice> connectedDevicesList = <BluetoothDevice>[];

  @override
  void initState() {
    super.initState();
    // Get all connected devices and add them to the list
    flutterBlue.connectedDevices.asStream().listen((List<BluetoothDevice> devices) {
      setState(() {
        connectedDevicesList = devices;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connected Bluetooth Devices'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Connected Bluetooth Devices: ${connectedDevicesList.length} '//?? 'Unknown Device',
                  ),
            Text('Connected  Devices Id : ${connectedDevicesList[0].id} '//?? 'Unknown Device',
                     ),
            Text('Connected  Devices Name : ${connectedDevicesList[0].name} '//?? 'Unknown Device',
                     ),
            Text('Connected  Devices Type : ${connectedDevicesList[0].type} '//?? 'Unknown Device',
                     ),
            Text('Connected  Devices Service : ${connectedDevicesList[0].isDiscoveringServices} '//?? 'Unknown Device',
                     ),                   
      
          ],
        ),
      )
      
    );
  }
}