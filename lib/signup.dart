import 'package:flutter/material.dart';
import 'package:healthapp/constants/msgline.dart';
import 'package:healthapp/login.dart';




class SignupScreen extends StatefulWidget{
  @override
  _SignupScreen createState()=>_SignupScreen();
}



class _SignupScreen extends State<SignupScreen>{
  TextEditingController _nameTEC=TextEditingController();
  TextEditingController _emailTEC=TextEditingController();
  TextEditingController _password1TEC=TextEditingController();
  TextEditingController _password2TEC=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title:Text("Login Screen")),
      backgroundColor:Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              msgLine(message: "Welcome"),
      
                CircleAvatar(
                  radius: 100,
                  backgroundImage: AssetImage('assets/images/create.png'),
                ),
              SizedBox(height: 20,),
               TextField(
               controller:_nameTEC,
               keyboardType: TextInputType.emailAddress,
               decoration: InputDecoration( 
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.verified_user),
                        hintText: "Enter Name Here",
                        hintStyle: TextStyle(fontSize: 20.0, color: Color(0xFFB80075)),
                        labelText: "Name",
                        labelStyle: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                                  ),
              ),
              SizedBox(height: 20,),
               TextField(
               controller:_emailTEC,
               keyboardType: TextInputType.emailAddress,
               decoration: InputDecoration( 
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                        hintText: "Enter Email Here",
                        hintStyle: TextStyle(fontSize: 20.0, color: Color(0xFFB80075)),
                        labelText: "Email",
                        labelStyle: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                                  ),
              ),
              SizedBox(height: 20,),
              TextField(
                          controller: _password1TEC,
                          obscureText: true,
                          decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.password),
                          hintText: "Enter Password Here",
                          hintStyle: TextStyle(fontSize: 20.0, color:Color(0xFFB80075)),
                          labelText: "Password",
                          labelStyle: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                          
                              ),
                        ),
              SizedBox(height: 20,),
              TextField(
                          controller: _password2TEC,
                          obscureText: true,
                          decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.password),
                          hintText: "Please Conform Password",
                          hintStyle: TextStyle(fontSize: 20.0, color:Color(0xFFB80075)),
                          labelText: "Conform Password",
                          labelStyle: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                          
                              ),
                        ),
              Row(
                mainAxisSize:MainAxisSize.max,
                mainAxisAlignment:MainAxisAlignment.center,
      
                children: [
                  TextButton(onPressed:(){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
                  }, child: Text("Login",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Color(0xFFB80075))),
                  ),
                  ElevatedButton(onPressed:(){
      
                    var _name=_nameTEC.text;
                    var _email=_emailTEC.text;
                    var _password1=_password1TEC.text;
                    var _password2=_password2TEC.text;
                    
                    print("Name:"+_name);
                    print("Email:"+_email);
                    print("password1:"+_password1);
                    print("password2:"+_password2);
                  },
                   child: Text(" Create ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),),
                  SizedBox(width: 20,),
                  
                  
                ],
              ),
             
              ],
            ),
          ),
        ),
      )
    );
  }
}