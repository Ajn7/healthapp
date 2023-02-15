import 'package:flutter/material.dart';
import 'package:healthapp/constants/msgline.dart';
import './startup.dart';
class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      backgroundColor:Colors.white,
      body: Column(children: [msgLine(message: "Welcome \n Back!"), 
                              const TextField(
                                decoration: InputDecoration( 
                               //border: OutlineInputBorder(),
                                hintText: "Enter Email Here",
                                hintStyle: TextStyle(fontSize: 20.0, color: Color(0xFFB80075)),
                                labelText: "Email",
                                labelStyle: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                                 ),
                                 ),
                                 const SizedBox(height: 30),
                                 const TextField(
                                          obscureText: true,
                                          decoration: InputDecoration(
                                            // border: OutlineInputBorder(),
                                          hintText: "Enter Password Here",
                                          hintStyle: TextStyle(fontSize: 20.0, color:Color(0xFFB80075)),
                                          labelText: "Password",
                                          labelStyle: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                                          ),
                                          ),
                       TextButton(
                      style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 25),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: const Text("Submit ",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                  ),],)
    );
  }
}

