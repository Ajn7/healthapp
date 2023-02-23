import 'package:flutter/material.dart';
import 'package:healthapp/constants/msgline.dart';
import 'package:healthapp/screens/login.dart';
import 'package:healthapp/screens/myhome.dart';




class SignupScreen extends StatefulWidget{
  const SignupScreen({super.key});

  @override
  _SignupScreen createState()=>_SignupScreen();
}



class _SignupScreen extends State<SignupScreen>{
  final GlobalKey<FormState> _key = GlobalKey();
  final TextEditingController _nameTEC=TextEditingController();
  final TextEditingController _emailTEC=TextEditingController();
  final TextEditingController _password1TEC=TextEditingController();
  final TextEditingController _password2TEC=TextEditingController();
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
                const SizedBox(height: 20,),
                 TextFormField(
                 controller:_nameTEC,
                 keyboardType: TextInputType.emailAddress,
                 decoration: const InputDecoration( 
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.verified_user),
                          hintText: "Enter Name Here",
                          hintStyle: TextStyle(fontSize: 20.0, ),
                          labelText: "Name",
                          labelStyle: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                                    ),
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
                const SizedBox(height: 20,),
                TextFormField(
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
                const SizedBox(height: 20,),
                TextFormField(
                            controller: _password2TEC,
                            obscureText: true,
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
                          ),
                Row(
                  mainAxisSize:MainAxisSize.max,
                  mainAxisAlignment:MainAxisAlignment.center,
                  
                  children: [
                    TextButton(onPressed:(){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
                    }, child: const Text("Login",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,)),
                    ),
                    ElevatedButton(onPressed:(){
                  
                      var name=_nameTEC.text;
                      var email0=_emailTEC.text;
                      var password1=_password1TEC.text;
                      var password2=_password2TEC.text;
                      
                      print("Name:"+name);
                      print("Email:"+email0);
                      print("password1:"+password1);
                      print("password2:"+password2);
            
                      var email=_emailTEC.text;
                      var password=_password1TEC.text;
                      final isValid = _key.currentState!.validate();
                      if (!isValid) {
                        return;
                      }
                      
                      _key.currentState!.save();

                      if(_password1TEC==_password2TEC){
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>MyHome(email: email, token:password)));
                      }
                    },
                     child: const Text(" Create ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),),
                    const SizedBox(width: 20,),
                    
                    
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