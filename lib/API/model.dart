//iqoo - 192.168.53.129
//bsnl - 192.168.1.23
//192.168.53.129
//hotspot:192.168.222.129


// List<dynamic>dta=[ ]; //dt
// List<dynamic>tme=[ ]; //dte
// dynamic prev=0;
// String name='';
// String email='';//'a';
// String baseurl='http://192.168.222.129:8000';
// int?id;
// int?age;
// double?height;
// double?weight;
// String bloodgroup='';
// String phone='';
// String notification='No data found please add reading';
import 'dart:io';

class DataStore {
  static final DataStore _instance = DataStore._internal();

  factory DataStore() {
    return _instance;
  }

  DataStore._internal();

  List<dynamic> dta = []; //dt
  List<dynamic> tme = []; //dte
  List<dynamic> bphdta = []; //dt
  List<dynamic> bpldta = []; //dt
  List<dynamic> bptme = [];
  dynamic prev = 0;
  dynamic bpprev = 0;

  String name = '';
  String email = ''; //'a';
  String baseurl = 'http://192.168.1.38:8000'; //flutter.compileSdkVersion
  int? id;
  int? age;
  double? height;
  double? weight;
  String bloodgroup = '';
  String phone = '';
  String image='';
  String notification = 'No data found please ';
  DateTime date=DateTime.now();
  DateTime datesp=DateTime.now();
  String spo2ServiceId ='6e400001-b5a3-f393-e0a9-e50e24dcca9e';//'5833ff01-9b8b-5191-6142-22a4536ef123' ;//
  String spo2CharacteristicId ='6e400003-b5a3-f393-e0a9-e50e24dcca9e';//'5833ff02-9b8b-5191-6142-22a4536ef123';//'6e400003-b5a3-f393-e0a9-e50e24dcca9e';
   String bpServiceId ='14839ac4-7d7e-415c-9a42-167340cf2339';//'5833ff01-9b8b-5191-6142-22a4536ef123' ;//
  String bpCharacteristicId ='0x2A37';//'0734594a-a8e7-4b1a-a6b1-cd5243059a57';

}