//iqoo - 192.168.53.129
//bsnl - 192.168.1.23
//192.168.53.129
//locla 10.0.0.1:8000
import 'dart:ffi';

List<dynamic>dta=[ ]; //dt
List<dynamic>tme=[' ']; //dte
dynamic prev=0;
String name='';
String email='';//'a';
String baseurl='http://192.168.1.23:8000';
int?id;
int?age;
double?height;
double?weight;
String bloodgroup='';
String?phone;




// class GlobalVariables {
//   static GlobalVariables? _instance;
//   int counter = 0;
//   List<dynamic>dta=[ ]; //dt
//   List<dynamic>tme=[' ']; //dte
//   dynamic prev=0;
//   String name='';
//   String email='';
//   String baseurl='http://192.168.1.23:8000';
//   factory GlobalVariables() {
//     _instance ??= GlobalVariables._internal();
//     return _instance!;
//   }

//   GlobalVariables._internal();
// }