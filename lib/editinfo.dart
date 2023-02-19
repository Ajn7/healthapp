import 'package:flutter/material.dart';
import 'package:healthapp/constants/msgline.dart';
import 'package:healthapp/login.dart';
import 'package:healthapp/myhome.dart';




class EditInfo extends StatefulWidget{
  @override
  _EditInfo createState()=>_EditInfo();
}



class _EditInfo extends State<EditInfo>{
  final items=['Male','Female','Not Inetersted'];
  String?value;
  TextEditingController _nameTEC=TextEditingController();
  TextEditingController _emailTEC=TextEditingController();
  TextEditingController _phoneTEC=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title:Text("Login Screen")),
      backgroundColor:Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding:EdgeInsets.symmetric(vertical: 20,horizontal: 20) ,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                msgLine(message: "EditProfile"),
                  
                  CircleAvatar(
                    radius: 80,
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
                          hintStyle: TextStyle(fontSize: 20.0, ),
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
                          prefixIcon: Icon(Icons.verified_user),
                          hintText: "Enter Email Here",
                          hintStyle: TextStyle(fontSize: 20.0, ),
                          labelText: "Email",
                          labelStyle: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                                    ),
                ),
                SizedBox(height: 20,),
                Container(
                  width:200,
                  padding: EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black,width: 4)
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value:value,
                      iconSize: 36,
                      isExpanded:true,
                      icon:Icon(Icons.arrow_drop_down,color: Colors.black,),
                      items: items.map(buildMenuItem).toList(),
                       onChanged: (value)=>setState(() => this.value=value),
                      ),
                  ),
                ),
                SizedBox(height:20),
                 TextField(
                 controller:_phoneTEC,
                 keyboardType: TextInputType.emailAddress,
                 decoration: InputDecoration( 
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                          hintText: "Enter Phone Number Here",
                          hintStyle: TextStyle(fontSize: 20.0, ), //color: Color(0xFFB80075)
                          labelText: "Phone",
                          labelStyle: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                                    ),
                ),
                Row(
                  mainAxisSize:MainAxisSize.max,
                  mainAxisAlignment:MainAxisAlignment.center,
                  
                  children: [
                    ElevatedButton(onPressed:(){
                  
                      var _name=_nameTEC.text;
                      var _email=_emailTEC.text;
                      var _phone=_phoneTEC.text;
                      
                      print("Name:"+_name);
                      print("Email:"+_email);
                      print("phone:"+_phone);
                      
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyHome(email: _email, password:_phone)));
                    },
                     child: Text(" Submit ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),),
                    SizedBox(width: 20,),
                    
                    
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

DropdownMenuItem<String>buildMenuItem(String item) => DropdownMenuItem(
  value:item,
  child:Text(
    item,
    style:TextStyle(fontSize: 20,fontWeight:FontWeight.bold)
  )
);