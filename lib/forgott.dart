import 'package:flutter/material.dart';
import 'package:healthapp/constants/msgline.dart';

class ForgottScreen extends StatefulWidget{
  @override
  _ForgottScreen createState()=>_ForgottScreen();
}



class _ForgottScreen extends State<ForgottScreen>{
  TextEditingController _emailTEC=TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title:Text("Login Screen")),
      backgroundColor:Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                msgLine(message: "Forgott your \n Password!"),
      
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/forgott.jpg'),
                  ),
                
                SizedBox(height: 10,),
                const SizedBox(
                  child: Text('Enter the email you used for signup'),
              
                ),
                SizedBox(height: 10,),
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
                Row(
                  mainAxisSize:MainAxisSize.max,
                  mainAxisAlignment:MainAxisAlignment.center,
      
                  children: [
                   
                    ElevatedButton(onPressed:(){
      
                      
                      var _email=_emailTEC.text;
                      
      
                      print("Email:"+_email);
                    
                    },
                     child: Text(" Submit ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),),
                    SizedBox(width: 20,),
                    
                    
                  ],
                ),
                SizedBox(height: 10),
                ],
              ),
            ),
          ),
          ),
      )
    );
  }
}