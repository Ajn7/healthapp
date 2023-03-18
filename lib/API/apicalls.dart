import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:healthapp/API/model.dart';
import 'package:healthapp/constants/sharedpref.dart';
import 'package:http/http.dart' as http;

 mixin API {
 Future getReading({required String date,required int vitalid}) async {
  // MySharedPreferences myPrefs = MySharedPreferences();
  // await myPrefs.initPrefs();
  String today=date.substring(0,10);
  //print('From getReading: $date ,,, $today');
  final response = await http.get(

    Uri.parse('$baseurl/vitalrecords/readings/date/list/?user=$id&date=$today&vitalid=$vitalid'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    
  );

  //decode
print('List of reading');
List<dynamic> data = jsonDecode(response.body);
print('from getReading::$data');
   
  if (response.statusCode == 200) {
     for (dynamic d in data) {
      dta.add(d['reading']);
      tme.add(DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(d['created_at']));
      }
    prev=dta.last;
    print('SP02 Data(init call from myHome) :$dta');

  } else {
    var res="response";
    print(res);
    //ScaffoldMessenger.of(context).showSnackBar (SnackBar(content: Text(res)));
    
   }
 }

 Future getUserData() async {
  
  MySharedPreferences myPrefs = MySharedPreferences();
  await myPrefs.initPrefs();
  String? myToken = myPrefs.getString('token');
  int? id = myPrefs.getInt('user_id');
  String em= myPrefs.getString('email').toString();
  print('api getUserData:$id');
  print('api getUserData:$em');

  final response = await http.get(
    
    Uri.parse('$baseurl/accounts/details/'),
    headers: <String, String>{
      'Authorization':'Token $myToken',
      'Content-Type': 'application/json; charset=UTF-8',
    },
    
  );

  final response1 = await http.get(
    
    Uri.parse('$baseurl/healthrecords/$em/'),
    headers: <String, String>{
      'Authorization':'Token $myToken',
      'Content-Type': 'application/json; charset=UTF-8',
    },
    
  );

  //decode
  Map<String, dynamic> data = jsonDecode(response.body);
  print('Details Api response(FutureBuilder call): ${response.body}');
  
  Map<String, dynamic> data1 = jsonDecode(response1.body);
  print('Details Api response1(FutureBuilder call): ${response1.body}');
  //print(tokens);
  //print(response.statusCode);
  if (response.statusCode == 200 ) {
  MySharedPreferences myPrefs = MySharedPreferences();
  await myPrefs.initPrefs();
  await myPrefs.setString('email',data['email']);
  if(data1['bloodgroup']!=null){
  await myPrefs.setString('bloodgroup',data1['bloodgroup']);
  }
  if(data1['age']!=null){
    await myPrefs.setInt('age',data1['age']);
  }
  if(data1['height']!=null){
  await myPrefs.setFloat('height',data1['height']);
  }
  if(data1['weight']!=null){
  await myPrefs.setFloat('weight',data1['weight']);
  }
  if(data1['bloodgroup']!=null){
  await myPrefs.setString('bloodgroup',data1['bloodgroup']);
  }
  if(data1['phone']!=null){
  await myPrefs.setString('phone',data1['phone']);
  }

  //String? email = myPrefs.getString('email');
 
    
  String firstname=data['first_name'];
  String lastname=data['last_name'];
  name='$firstname $lastname';
  await myPrefs.setString('name',name);
  email=myPrefs.getString('email').toString(); 
  name=myPrefs.getString('name').toString();   
  age=myPrefs.getInt('age');  
  height=myPrefs.getFloat('height');  
  weight=myPrefs.getFloat('weight');  
  bloodgroup=myPrefs.getString('bloodgroup').toString();   
  phone=myPrefs.getString('phone').toString();          //data['email'];
  print('Name at deatils api global variable :$name');
  print('Email at deatils api global variable :$email');
  print('age at deatils api global variable :$age');
  print('height at deatils api global variable :$height');
  print('weight at deatils api global variable :$weight');
  print('bloodgroup at deatils api global variable :$bloodgroup');
  print('phone at deatils api global variable :$phone');
 
    
  } else {
//     showDialog(
//   context: context,
//   builder: (context) => AlertDialog(
//     title: Text('Error'),
//     content: Text('Unable to connect to server'),
//     actions: [
//       TextButton(
//         onPressed: () => Navigator.of(context).pop(),
//         child: Text('OK'),
//       ),
//     ],
//   ),
// );

    var res=data['deatil'];
    print('Reponse of error in details api : $res');
    //ScaffoldMessenger.of(context).showSnackBar (SnackBar(content: Text(res)));
    
   }
 }

 Future editUserData(
 {required int age,
 required String bg,
 required String phone,
 required double height,
 required double weight}
 ) async {
  MySharedPreferences myPrefs = MySharedPreferences();
  await myPrefs.initPrefs();
  String? myToken = myPrefs.getString('token');
  final response = await http.put(

    Uri.parse('$baseurl/healthrecords/$email/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization':'Token $myToken'
    },
    body: jsonEncode(
    <String, dynamic>{
    'email': email,
    'age': age,
    'height': height,
    'weight': weight,
    'bloodgroup': bg,
    'phone': phone,
    'user': id,
    }),
    
  );

  print('Edit info api response body');
  print(response.body);
  //decode
  Map<String, dynamic> data = jsonDecode(response.body);
  
   
  if (response.statusCode == 200) {

    
    print('SP02 Data(init call from myHome) :$dta');

  } else {
    var res="response";
    print(res);
    //ScaffoldMessenger.of(context).showSnackBar (SnackBar(content: Text(res)));
    
   }
 }

 Future addRecord({required int reading,required int vitalid}) async {
  final response = await http.post(
  
    Uri.parse('$baseurl/vitalrecords/reading/add/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String,dynamic>{
      'reading':reading,
      'vital':vitalid,
      'user':id,
    }),
  );

  //decode
  Map<String, dynamic> data = jsonDecode(response.body);
   
  if (response.statusCode == 200) {
    print('Successfull');
  }
   
 
}
 }

 