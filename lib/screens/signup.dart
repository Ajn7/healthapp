import 'dart:convert';
import 'package:healthapp/API/model.dart';
import 'package:healthapp/constants/sharedpref.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:healthapp/constants/divider.dart';
import 'package:healthapp/constants/msgline.dart';
//import 'package:healthapp/main.dart';
import 'package:healthapp/screens/login.dart';
import 'package:healthapp/screens/myhome.dart';
//import 'package:shared_preferences/shared_preferences.dart';



class SignupScreen extends StatefulWidget{
  const SignupScreen({super.key});

  @override
  _SignupScreen createState()=>_SignupScreen();
}



class _SignupScreen extends State<SignupScreen>{
  String _password='empty';
  final GlobalKey<FormState> _key = GlobalKey();
  final TextEditingController _nameTEC=TextEditingController();
  final TextEditingController _lastnameTEC=TextEditingController();
  final TextEditingController _emailTEC=TextEditingController();
  final TextEditingController _password1TEC=TextEditingController();
  final TextEditingController _password2TEC=TextEditingController();
  
  // Initially password is obscure
  bool _obscureText = true;

  Future signup({required String email,
  required String password1,
  required String password2,
  required String name,
  required String last_name,
  required BuildContext context}) 
  async {
  final response = await http.post(
   
    Uri.parse('$baseurl/accounts/register/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'first_name':name,
      'last_name':last_name,
      'email':email,
      'password': password1,
      'password2':password2
    }),
  );

  //decode
  Map<String, dynamic> data = jsonDecode(response.body);
   
  if (response.statusCode == 200) {

    // Login successful
     var token = data["token"];
     email = data["email"];
     //print('token of login: $token');

    MySharedPreferences myPrefs = MySharedPreferences();
    await myPrefs.initPrefs();
    await myPrefs.setString('token', '$token');
    String? myToken = myPrefs.getString('token');
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>MyHome(token:'$myToken')));
    
  } else {
    var res=data["response"];
    ScaffoldMessenger.of(context).showSnackBar (SnackBar(content: Text(res)));
    
   }
}
  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title:Text("Login Screen")),
      backgroundColor:Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key:_key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                msgLine(message: "Welcome"),
                  
                  const CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage('assets/images/create.png'),
                  ),
                horizontaSpace(20),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: TextFormField(
                   controller:_nameTEC,
                   keyboardType: TextInputType.emailAddress,
                   decoration: const InputDecoration( 
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.drive_file_rename_outline),
                            hintText: "Enter Name Here",
                            hintStyle: TextStyle(fontSize: 20.0, ),
                            labelText: "Name",
                            labelStyle: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                                      ),
                                      validator: (value) {
                            if (value!.isEmpty) {
                            return 'Enter a name!';
                            }
                            return null;
                            },
                                 ),
                 ),
                horizontaSpace(20),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: TextFormField(
                   controller:_lastnameTEC,
                   keyboardType: TextInputType.emailAddress,
                   decoration: const InputDecoration( 
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.drive_file_rename_outline),
                            hintText: "Enter Last Name Here",
                            hintStyle: TextStyle(fontSize: 20.0, ),
                            labelText: "Last Name",
                            labelStyle: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                                      ),
                                      validator: (value) {
                            if (value!.isEmpty) {
                            return 'Enter a last name!';
                            }
                            return null;
                            },
                                 ),
                 ),
                horizontaSpace(20),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: TextFormField(
                   controller:_emailTEC,
                   keyboardType: TextInputType.emailAddress,
                   decoration: const InputDecoration( 
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.email),
                            hintText: "Enter Email Here",
                            hintStyle: TextStyle(fontSize: 20.0, ), 
                            labelText: "Email",
                            labelStyle: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                                      ),
                            validator: (value) {
                            if (value!.isEmpty || !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                                return 'Enter a valid email!';
                              }
                              return null;
                                 },
                                 ),
                 ),
                horizontaSpace(20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                              controller: _password1TEC,
                              obscureText: true,
                              decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.password),
                              hintText: "Enter Password Here",
                              hintStyle: TextStyle(fontSize: 20.0,),
                              labelText: "Password",
                              labelStyle: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                              
                                  ),
                            validator: (value) {
                            if (value!.isEmpty) {
                            return 'Enter a valid password!';
                            }
                            return null;
                            },
                            ),
                ),
                horizontaSpace(20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                              controller: _password2TEC,
                              obscureText: _obscureText,
                              decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.password),
                              hintText: "Please Conform Password",
                              hintStyle: TextStyle(fontSize: 20.0,),
                              labelText: "Conform Password",
                              labelStyle: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                              
                              
                                  ),

                                  validator: (value) {
                            if (value!.isEmpty) {
                            return 'Enter a valid password!';
                            }
                            return null;
                            },
                           onSaved: (value) => _password = value!,
                            ),
                ),
                TextButton(
                onPressed: _toggle,
                child: Text(_obscureText ? "Show Password" : "Hide")),
                Row(
                  mainAxisSize:MainAxisSize.max,
                  mainAxisAlignment:MainAxisAlignment.center,
                  
                  children: [
                    TextButton(onPressed:(){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
                    }, child: const Text("Login",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,)),
                    ),
                    ElevatedButton(onPressed:(){
                  
                      var name=_nameTEC.text;
                      var email=_emailTEC.text;
                      var last=_lastnameTEC.text;
                      var password1=_password1TEC.text;
                      var password2=_password2TEC.text;
                      
                      final isValid = _key.currentState!.validate();
                      if (!isValid) {
                        return;
                      }
                      
                      signup(name:name,email:email,last_name:last,password1:password1,password2:password2,context:context);
        
                      if(_password1TEC==_password2TEC){
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>MyHome(token:password1)));
                      }
                    },
                     child: const Text(" Create ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                     ),
                    horizontaSpace(20),
                    
                    
                  ],
                ),
               
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}