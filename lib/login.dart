import 'package:flutter/material.dart';
import 'package:healthapp/constants/msgline.dart';
import 'package:healthapp/forgott.dart';
import 'package:healthapp/myhome.dart';
import 'package:healthapp/signup.dart';
//import './startup.dart';


class LoginScreen extends StatefulWidget{
  @override
  _LoginScreenState createState()=>_LoginScreenState();
}



class _LoginScreenState extends State<LoginScreen>{
  TextEditingController _emailTEC=TextEditingController();
  TextEditingController _passwordTEC=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title:Text("Login Screen")),
      backgroundColor:Colors.white,
      body: SafeArea(
        child:Padding(
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
              
              SizedBox(height: 20,),
               TextField(
               controller:_emailTEC,
               keyboardType: TextInputType.emailAddress,
               decoration: InputDecoration( 
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                        hintText: "Enter Email Here",
                        hintStyle: TextStyle(fontSize: 20.0, ),
                        labelText: "Email",
                        labelStyle: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                                  ),
              ),
              SizedBox(height: 20,),
              TextField(
                          controller: _passwordTEC,
                          obscureText: true,
                          decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock),
                          hintText: "Enter Password Here",
                          hintStyle: TextStyle(fontSize: 20.0, ),
                          labelText: "Password",
                          labelStyle: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                          
                              ),
                        ),
              SizedBox(height: 20,),
              Row(
                mainAxisSize:MainAxisSize.max,
                mainAxisAlignment:MainAxisAlignment.center,

                children: [
                  TextButton(onPressed:(){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignupScreen()));
                  }, child: Text("Sign Up",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Color(0xFFB80075))),),
                  ElevatedButton(onPressed:(){

                    
                    var email=_emailTEC.text;
                    var password=_passwordTEC.text;
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyHome(email: email, password:password)));
                  },
                   child: Text(" Login ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),),
                  SizedBox(width: 20,),
                  
                  
                ],
              ),
              TextButton(onPressed:(){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ForgottScreen()));
              }, child: Text("forgot your password?",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:Colors.red.shade400, decoration: TextDecoration.underline),),),

              ],
            ),
          ),
        ),
        ),
      ),
    );
  }
}
