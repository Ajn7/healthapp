 import 'dart:convert';
import 'package:healthapp/API/model.dart';
import 'package:healthapp/main.dart';
import 'package:healthapp/screens/startup.dart';
import 'package:http/http.dart' as http;
 
 Future getReading() async {
  final response = await http.get(
    Uri.parse('http://192.168.1.23:8000/reading/list/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    
  );

  //decode
  Map<String, dynamic> data = jsonDecode(response.body);
  
   
  if (response.statusCode == 200) {

    tme=data['time'];
    dta=data['reading'];
    print(dta);

  } else {
    var res="response";
    print(res);
    //ScaffoldMessenger.of(context).showSnackBar (SnackBar(content: Text(res)));
    
   }
 }

 Future getUserData() async {
  final response = await http.get(
    Uri.parse('http://192.168.1.23:8000/accounts/details/'),
    headers: <String, String>{
      'Authorization':'Token $token',
      'Content-Type': 'application/json; charset=UTF-8',
    },
    
  );

  //decode
  Map<String, dynamic> data = jsonDecode(response.body);
  print(response.body);
  print(token);
  //print(tokens);
  
  if (response.statusCode == 200) {
    firstname=data['first_name'];
    lastname=data['last_name'];
    email=data['email'];
    name='$firstname $lastname';
    
  } else {
    var res=data['deatil'];
    print(res);
    //ScaffoldMessenger.of(context).showSnackBar (SnackBar(content: Text(res)));
    
   }
 }