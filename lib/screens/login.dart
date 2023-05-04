import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:healthapp/API/model.dart';
import 'package:healthapp/constants/divider.dart';
import 'package:healthapp/constants/msgline.dart';
import 'package:healthapp/constants/sharedpref.dart';
import 'package:healthapp/core/navigator.dart';
import 'package:http/http.dart' as http;
import 'package:healthapp/screens/forgott.dart';
import 'package:healthapp/screens/signup.dart';
DataStore dataStore=DataStore();
class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState()=>_LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _key = GlobalKey();
  final TextEditingController _emailTEC=TextEditingController();
  final TextEditingController _passwordTEC=TextEditingController();
  
  Future login(String email, String password,BuildContext context) async {
  final response = await http.post(
  
    Uri.parse('${dataStore.baseurl}/accounts/login/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }),
  );

  //decode
  Map<String, dynamic> data = jsonDecode(response.body);
   
  if (response.statusCode == 200) {

    // Login successful
     var logintoken = data["token"];
     email = data["email"];
     var id=data["id"];
     print('token of login: $logintoken');

    //  SharedPreferences pref =await SharedPreferences.getInstance();
    //  await pref.setString(tokens,token);
    //VariableUtilities().token=token;
  MySharedPreferences myPrefs = MySharedPreferences();
  await myPrefs.initPrefs();
  await myPrefs.setString('token', '$logintoken');
  await myPrefs.setString('email', email);
  await myPrefs.setInt('user_id', id);
  String? myToken = myPrefs.getString('token');
  int? ids = myPrefs.getInt('user_id');
  dataStore.id=ids;
  var em=myPrefs.getString('email');
  //bool keyExists = myPrefs.containsKey('myKey');
  //bool keyRemoved = await myPrefs.remove('myKey');
  print("login  shared pref token : ${myToken}");
  print("login shared pref id : ${ids}");
  print("login shared pref email : ${em}");
  navigatorKey?.currentState?.pushReplacementNamed("homescreen");
  //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>MyHome()));
    
  } else {
    var res=data["response"];
    ScaffoldMessenger.of(context).showSnackBar (SnackBar(content: Text(res)));
    
   }
}

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title:Text("Login Screen")),
      backgroundColor:Colors.white,
      body: SafeArea(
        child:Form(
          key: _key,
          //autovalidate:_autoValidate,
          child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                msgLine(message: "Welcome Back!"),
        
                  const CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage('assets/images/login.png'),
                  ),
                
                const SizedBox(height: 20,),
                TextFormField(
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
                verticalSpace(20),
                TextFormField(
                            controller: _passwordTEC,
                            obscureText: true,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.lock),
                              hintText: "Enter Password Here",
                              hintStyle: TextStyle(fontSize: 20.0, ),
                              labelText: "Password",
                              labelStyle: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),                            
                              ),
                            validator: (value) {
                                                  //empty
                                                  if (value!.isEmpty) {
                                                   return 'Enter a valid password!';
                                                   }
                                                   //check length
                                                 if (value.length < 8) {
                                                  return 'Password must contain 8 characters';
                                                   }
                                                 // Check one uppercase letter
                                                if (value.toLowerCase() == value) {
                                                  return 'Password must contain atleast one uppercase letter';
                                                    }

                                                // Check one lowercase letter
                                                if (value.toUpperCase() == value) {
                                                  return 'Password must contain atleast one lowercase letter';
                                                     }

                                                // Check for at least one number
                                               if (!value.contains(RegExp(r'\d'))) {
                                                   return 'Password must contain atleast one number';
                                                 }
                                                 return null;
                                  },
                          ),
                verticalSpace(20),
                Row(
                  mainAxisSize:MainAxisSize.max,
                  mainAxisAlignment:MainAxisAlignment.center,
        
                  children: [
                    TextButton( 
                      onPressed: () {
                    
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SignupScreen()));
                      },
                     child: const Text("Sign Up",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Color(0xFFB80075))),
                     ),
                    ElevatedButton(
                    onPressed:(){
                      final isValid = _key.currentState!.validate();
                      if (!isValid) {
                           return ;
                       }
                      login(_emailTEC.text,_passwordTEC.text,context);
                    },
                    child: const Text(" Login ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(width: 20,),
                    
                    
                  ],
                ),
                TextButton(
                  child: Text("forgot your password?",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color:Colors.red.shade400, 
                    decoration: TextDecoration.underline
                    ),
                    ),
                onPressed:(){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ForgottScreen()));
                }, ),
        
                ],
              ),
            ),
          ),
          ),
        ),
      ),
    );
  }
}




 

  