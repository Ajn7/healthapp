 import 'dart:convert';
import 'package:healthapp/API/model.dart';
import 'package:healthapp/constants/sharedpref.dart';
import 'package:http/http.dart' as http;
 
 
 Future getReading() async {
  final response = await http.get(

    Uri.parse('$baseurl/reading/list/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    
  );

  //decode
  Map<String, dynamic> data = jsonDecode(response.body);
  
   
  if (response.statusCode == 200) {

    tme=data['time'];
    dta=data['reading'];
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
  final response = await http.get(
    
    Uri.parse('$baseurl/accounts/details/'),
    headers: <String, String>{
      'Authorization':'Token $myToken',
      'Content-Type': 'application/json; charset=UTF-8',
    },
    
  );

  //decode
  Map<String, dynamic> data = jsonDecode(response.body);
  print('Details Api response: ${response.body}');
  
  //print(tokens);
  
  if (response.statusCode == 200) {
  //MySharedPreferences myPrefs = MySharedPreferences();
  //await myPrefs.initPrefs();
  //await myPrefs.setString('email',data['email']);
  //String? myToken = myPrefs.getString('email');

   
    firstname=data['first_name'];
    lastname=data['last_name'];
    email=myPrefs.getString('email').toString();                             //data['email'];
    name='$firstname $lastname';
    
  } else {
    var res=data['deatil'];
    print('Reponse of error in details api : $res');
    //ScaffoldMessenger.of(context).showSnackBar (SnackBar(content: Text(res)));
    
   }
 }