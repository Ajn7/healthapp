import 'package:flutter/material.dart';
import 'package:healthapp/constants/msgline.dart';
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              msgLine(message: "Welcome Back!"),

                CircleAvatar(
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
                        hintStyle: TextStyle(fontSize: 20.0, color: Color(0xFFB80075)),
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
                          hintStyle: TextStyle(fontSize: 20.0, color:Color(0xFFB80075)),
                          labelText: "Password",
                          labelStyle: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                          
                              ),
                        ),
              SizedBox(height: 20,),
              Row(
                mainAxisSize:MainAxisSize.max,
                mainAxisAlignment:MainAxisAlignment.center,

                children: [
                  TextButton(onPressed:(){}, child: Text("Sign Up",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Color(0xFFB80075))),),
                  ElevatedButton(onPressed:(){
                    var _email=_emailTEC.text;
                    var _password=_passwordTEC.text;

                    print("Email:"+_email);
                    print("password:"+_password);
                  },
                   child: Text(" Login ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),),
                  SizedBox(width: 20,),
                  
                  
                ],
              ),
              SizedBox(height: 10),
              TextButton(onPressed:(){}, child: Text("forgott password",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:Colors.red)),),

              ],
            ),
          ),
        ),
        )
    );
  }
}














//     Column(children: [msgLine(message: "Welcome \n Back!"), 
//                               const TextField(
//                                 keyboardType: TextInputType.emailAddress,
//                                 decoration: InputDecoration( 
//                                 border: OutlineInputBorder(),
//                                  prefixIcon: Icon(Icons.email),
//                                 hintText: "Enter Email Here",
//                                 hintStyle: TextStyle(fontSize: 20.0, color: Color(0xFFB80075)),
//                                 labelText: "Email",
//                                 labelStyle: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
//                                  ),
//                                  ),
//                                  const SizedBox(height: 30),
//                                  const TextField(
//                                           obscureText: true,
//                                           decoration: InputDecoration(
//                                             // border: OutlineInputBorder(),
//                                           prefixIcon: Icon(Icons.lock),
//                                           hintText: "Enter Password Here",
//                                           hintStyle: TextStyle(fontSize: 20.0, color:Color(0xFFB80075)),
//                                           labelText: "Password",
//                                           labelStyle: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
//                                           border: OutlineInputBorder(),
//                                           ),
//                                           ),
//                        TextButton(
//                       style: TextButton.styleFrom(
//                       textStyle: const TextStyle(fontSize: 25),
//                     ),
//                     onPressed: () {
//                       Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()));
//                     },
//                     child: const Text("Submit ",
//                         style: TextStyle(
//                             color: Colors.black, fontWeight: FontWeight.bold)),
//                   ),],)
//     );
//   }
// }

