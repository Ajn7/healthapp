import 'package:flutter/material.dart';
import 'package:healthapp/constants/msgline.dart';

class ForgottScreen extends StatefulWidget{
  const ForgottScreen({super.key});

  @override
  _ForgottScreen createState()=>_ForgottScreen();
}



class _ForgottScreen extends State<ForgottScreen>{
  final TextEditingController _emailTEC = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey();
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
              child: Form(
                key: _key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  msgLine(message: "Forgott your \n Password!"),
                    
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/images/forgott.jpg'),
                    ),
                  
                  const SizedBox(height: 10,),
                  const SizedBox(
                    child: Text('Enter the email you used for signup'),
                
                  ),
                  const SizedBox(height: 10,),
                   TextFormField(
                   controller:_emailTEC,
                   keyboardType: TextInputType.emailAddress,
                   decoration: const InputDecoration( 
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.email),
                            hintText: "Enter Email Here",
                            hintStyle: TextStyle(fontSize: 20.0, color: Color(0xFFB80075)),
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
                  Row(
                    mainAxisSize:MainAxisSize.max,
                    mainAxisAlignment:MainAxisAlignment.center,
                    
                    children: [
                     
                      ElevatedButton(onPressed:(){
                      var email=_emailTEC.text;
                        
                       final isValid = _key.currentState!.validate();
                      if (!isValid) {
                           return ;
                       }
                      _key.currentState!.save();
                      print("Email:"+email);
                      
                      },
                       child: const Text(" Submit ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),),
                      const SizedBox(width: 20),
                      
                      
                    ],
                  ),
                  const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
          ),
      )
    );
  }
}