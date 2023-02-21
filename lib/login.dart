import 'package:flutter/material.dart';
import 'package:healthapp/constants/msgline.dart';
import 'package:healthapp/forgott.dart';
import 'package:healthapp/myhome.dart';
import 'package:healthapp/signup.dart';
//import './startup.dart';


class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState()=>_LoginScreenState();
}



class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _key = GlobalKey();
  //bool _autoValidate = false;
  TextEditingController _emailTEC=TextEditingController();
  TextEditingController _passwordTEC=TextEditingController();

   
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
                const SizedBox(height: 20,),
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
                const SizedBox(height: 20,),
                Row(
                  mainAxisSize:MainAxisSize.max,
                  mainAxisAlignment:MainAxisAlignment.center,
        
                  children: [
                    TextButton( onPressed: () {
                    
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SignupScreen()));
                    },
                     child: const Text("Sign Up",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Color(0xFFB80075))),),
                    ElevatedButton(onPressed:(){
                      var email=_emailTEC.text;
                      var password=_passwordTEC.text;
                      final isValid = _key.currentState!.validate();
                      if (!isValid) {
                           return ;
                       }
                      _key.currentState!.save();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>MyHome(email: email, password:password)));
                     
                    },
                     child: const Text(" Login ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),),
                    const SizedBox(width: 20,),
                    
                    
                  ],
                ),
                TextButton(child: Text("forgot your password?",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:Colors.red.shade400, decoration: TextDecoration.underline),),
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




 

  