 import 'dart:convert';
import 'package:healthapp/API/model.dart';
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

    dte=data['time'];
    dt=data['reading'];
    print(dt);

  } else {
    var res="response";
    print(res);
    //ScaffoldMessenger.of(context).showSnackBar (SnackBar(content: Text(res)));
    
   }
 }