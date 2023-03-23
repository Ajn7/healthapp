import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:healthapp/API/model.dart';
import 'package:healthapp/constants/sharedpref.dart';
import 'package:http/http.dart' as http;

DataStore dataStore = DataStore();
 mixin API {
//  Future getLastData({required int vitalid}) async {
//   // MySharedPreferences myPrefs = MySharedPreferences();
//   // await myPrefs.initPrefs();
//   String date=DateTime.now().toString();
//   String today=date.substring(0,10);
//   print('From lastdatagetReading');
//   final response = await http.get(

//     Uri.parse('${dataStore.baseurl}/vitalrecords/readings/date/list/?user=${dataStore.id}+&date=$today&vitalid=$vitalid'),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
    
//   );
// List<dynamic> data = jsonDecode(response.body);
//   print('last status:${response.statusCode},$today');
//   if (response.statusCode == 200) {
//     MySharedPreferences myPrefs = MySharedPreferences();
//     await myPrefs.initPrefs();
    
//     List<dynamic>? lastdata=[];
//      for (dynamic d in data) {
//       lastdata.add(d['reading']);
//       print('last data ${lastdata.last}');
//       await myPrefs.setString('Last',lastdata.last);
//       }



//   } else {
//     var res="No data for the given date ";
//     MySharedPreferences myPrefs = MySharedPreferences();
//     await myPrefs.initPrefs();
//     String l='0';
//     await myPrefs.setString('Last',l);
//     print(res);
//    }

//  }
 Future getReading({required String date,required int vitalid}) async {
  // MySharedPreferences myPrefs = MySharedPreferences();
  // await myPrefs.initPrefs();
  String today=date.substring(0,10);
  //print('From getReading: $date ,,, $today');
  final response = await http.get(

    Uri.parse('${dataStore.baseurl}/vitalrecords/readings/date/list/?user=${dataStore.id}+&date=$today&vitalid=$vitalid'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    
  );

  //decode
//try{
List<dynamic> data = jsonDecode(response.body);
print('from getReading api ::$data');
print(response.statusCode);
   
  
  if (response.statusCode == 200) {
    MySharedPreferences myPrefs = MySharedPreferences();
    await myPrefs.initPrefs();
    
    //List<dynamic>? dta = myPrefs.getList('dta');
     dataStore.dta=[ ]; //dt
     dataStore.tme=[ ];
     for (dynamic d in data) {
      dataStore.dta.add(d['reading']);
      dataStore.tme.add(DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(d['created_at']).toString());
      
      }
    await myPrefs.setList('data',dataStore.dta);
    await myPrefs.setList('time',dataStore.tme);
    print('apicall shareddate');
    print(myPrefs.getList('data')); 
    print('apicall datstore.dta');
    print(dataStore.dta); 
    dataStore.prev=dataStore.dta.last;
    // Timer(const Duration(seconds:3),(){
      
    // });

  } else {
    dataStore.dta=['0']; //dt
    dataStore.tme=[ ];
    var res="response";
    print(res+'${dataStore.dta.last}');
    //ScaffoldMessenger.of(context).showSnackBar (SnackBar(content: Text(res)));
    
   }
// }catch (FormatException) {
  
//   dataStore.dta=[ ]; //dt
//   dataStore.tme=[ ];
//   dataStore.notification='No data found please add reading';
// }
 
 }
  Future getReadingBp({required String date,required int vitalid}) async {
  // MySharedPreferences myPrefs = MySharedPreferences();
  // await myPrefs.initPrefs();
  String today=date.substring(0,10);
  //print('From getReading: $date ,,, $today');
  final response = await http.get(

    Uri.parse('${dataStore.baseurl}/vitalrecords/readings/date/list/?user=${dataStore.id}+&date=$today&vitalid=$vitalid'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    
  );

  //decode
//try{
List<dynamic> data = jsonDecode(response.body);
print('from getbpReading api ::$data');
print(response.statusCode);
   
  
  if (response.statusCode == 200) {
    MySharedPreferences myPrefs = MySharedPreferences();
    await myPrefs.initPrefs();
    
    //List<dynamic>? dta = myPrefs.getList('dta');
     dataStore.bphdta=[ ];
     dataStore.bpldta=[ ]; //dt
     dataStore.bptme=[ ];
     var i=0;
     for (dynamic d in data) {
      dataStore.bptme.add(DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(d['created_at']).toString());
  var name = d['reading'];
  dataStore.bpprev=d['reading'];
  var rd = '';
  int i = 0;
  // Extract the first value
  for (i = 0; i < name.length; i++) {
    if (name[i] == '/') {
      break;
    }
    rd += name[i];
  }
  dataStore.bpldta.add(rd);
  // Extract the second value
  rd = '';
  for (int j = i + 1; j < name.length; j++) {
    
    rd += name[j];
  }
  dataStore.bphdta.add(rd);
}
  
    
    print('apicall bphreading');
    print(dataStore.bphdta); 
    print('apicall bpldata');
    print(dataStore.bpldta); 
    

  } else {
    dataStore.bphdta=['0']; 
    dataStore.bpldta=['0'];//dt
    dataStore.bptme=[ ];
    var res="response";
    print(res+'${dataStore.dta.last}');
    //ScaffoldMessenger.of(context).showSnackBar (SnackBar(content: Text(res)));
    
   }
// }catch (FormatException) {
  
//   dataStore.dta=[ ]; //dt
//   dataStore.tme=[ ];
//   dataStore.notification='No data found please add reading';
// }
 
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
    
    Uri.parse('${dataStore.baseurl}/accounts/details/'),
    headers: <String, String>{
      'Authorization':'Token $myToken',
      'Content-Type': 'application/json; charset=UTF-8',
    },
    
  );

  final response1 = await http.get(
    
    Uri.parse('${dataStore.baseurl}/healthrecords/$em/'),
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
  dataStore.name='$firstname $lastname';
  await myPrefs.setString('name',dataStore.name);
  dataStore.email=myPrefs.getString('email').toString(); 
  dataStore.name=myPrefs.getString('name').toString();   
  dataStore.age=myPrefs.getInt('age');  
  dataStore.height=myPrefs.getFloat('height');  
  dataStore.weight=myPrefs.getFloat('weight');  
  dataStore.bloodgroup=myPrefs.getString('bloodgroup').toString();   
  dataStore.phone=myPrefs.getString('phone').toString();          //data['email'];
  print('Name at deatils api global variable :${dataStore.name}');
  print('Email at deatils api global variable :${dataStore.email}');
  print('age at deatils api global variable :${dataStore.age}');
  print('height at deatils api global variable :${dataStore.height}');
  print('weight at deatils api global variable :${dataStore.weight}');
  print('bloodgroup at deatils api global variable :${dataStore.bloodgroup}');
  print('phone at deatils api global variable :${dataStore.phone}');
 
    
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

    Uri.parse('${dataStore.baseurl}/healthrecords/${dataStore.email}/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization':'Token $myToken'
    },
    body: jsonEncode(
    <String, dynamic>{
    'email': dataStore.email,
    'age': age,
    'height': height,
    'weight': weight,
    'bloodgroup': bg,
    'phone': phone,
    'user': dataStore.id,
    }),
    
  );

  print('Edit info api response body');
  print(response.body);
  //decode
  Map<String, dynamic> data = jsonDecode(response.body);
  
   
  if (response.statusCode == 200) {

    
    print('SP02 Data(init call from myHome) :${dataStore.dta}');

  } else {
    var res="response";
    print(res);
    //ScaffoldMessenger.of(context).showSnackBar (SnackBar(content: Text(res)));
    
   }
 }

 Future addRecord({required int reading,required int vitalid}) async {
  final response = await http.post(
  
    Uri.parse('${dataStore.baseurl}/vitalrecords/reading/add/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String,dynamic>{
      'reading':reading,
      'vital':vitalid,
      'user':dataStore.id,
    }),
  );

  //decode
  Map<String, dynamic> data = jsonDecode(response.body);
  if (response.statusCode!= 201) {
    
    print('Un Successfull');
  }
   getReading(date: DateTime.now().toString(), vitalid: 1);
 
}
 }

 