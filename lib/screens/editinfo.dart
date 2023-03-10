import 'package:flutter/material.dart';
import 'package:healthapp/API/model.dart';
import 'package:healthapp/constants/divider.dart';
import 'package:healthapp/constants/msgline.dart';
import 'package:healthapp/core/navigator.dart';
import 'package:healthapp/API/apicalls.dart';

class EditInfo extends StatefulWidget{
  const EditInfo({super.key});

  @override
  State<EditInfo> createState()=>_EditInfo();
}



class _EditInfo extends State<EditInfo> with API{
  final GlobalKey<FormState> _key = GlobalKey();
  //final items=['M','F','NIL'];
  final bloodgroups=['A+ve','A-ve','B+ve','B-ve','O+ve','O-ve'];

  String?value1;
  String?value2=bloodgroup;

  //final TextEditingController _nameTEC=TextEditingController();
  //final TextEditingController _emailTEC=TextEditingController();
  final TextEditingController _phoneTEC=TextEditingController();
  final TextEditingController _weightTEC=TextEditingController();
  final TextEditingController _heightTEC=TextEditingController();
  final TextEditingController _ageTEC=TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      //appBar: AppBar(title:Text("Login Screen")),
      backgroundColor:Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding:const EdgeInsets.symmetric(vertical: 20,horizontal: 20) ,
              child: Form(
                key: _key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  msgLine(message: "Edit Profile"),
                   Image.asset(
                  'assets/images/login.png',
                      height: 150,
                      width: 200,
                    //color: Colors.red,
                      colorBlendMode: BlendMode.darken,
                ),
                TextButton(onPressed: (){ }, 
                child: const Text('Change Photo')
                ),
                
                  //const SizedBox(height: 20,),
                  // Row(
                  //   children: [
                  //     const Text('Name :',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  //      SizedBox(
                  //       width: 250,
                  //        child: TextFormField(
                  //        controller:_nameTEC,
                  //        keyboardType: TextInputType.name,
                  //        decoration: const InputDecoration( 
                  //                 border: OutlineInputBorder(),
                  //                           ),
                  //         validator: (value) {
                  //         if (value!.isEmpty ) {
                  //         return 'Enter a valid name!';
                  //         }
                  //         return null;
                  //         },
                  //       ),
                  //      ),
                  //   ],
                  // ),
                  // const SizedBox(height: 20,),
                  // Row(
                  //   children: [
                  //     const Text('Email :',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  //      SizedBox(
                  //       width: 250,
                  //        child: TextFormField(
                  //        controller:_emailTEC,
                  //        keyboardType: TextInputType.emailAddress,
                  //        decoration: const InputDecoration( 
                  //                 border: OutlineInputBorder(),
                  //                           ),
                  //         validator: (value) {
                  //                      if (value!.isEmpty || !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                  //                       return 'Enter a valid email!';
                  //                      }
                  //                      return null;
                  //                     },
                  //                      ),
                  //      ),
                  //   ],
                  // ),
                  verticalSpace(20),
                  
                  Row(
                   // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [ 
                    //   const Text('Gender:',style: TextStyle(fontWeight: FontWeight.bold),),
                    //   Container(
                    //   width:100,
                    //   height: 40,
                    //   padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(12),
                    //     border: Border.all(color: Colors.black)
                    //   ),
                    //   child: DropdownButtonHideUnderline(
                    //     child: DropdownButton<String>(
                    //       //hint: Text("Gender"),
                    //       value:value1,
                    //       iconSize: 36,
                    //       isExpanded:true,
                    //       icon:const Icon(Icons.arrow_drop_down,color: Colors.black,),
                    //       items: items.map(buildMenuItem).toList(),
                    //        onChanged: (value1)=>setState(() => this.value1=value1),
                    //       ),
                    //   ),
                    // ),
                    horizontaSpace(10),
                    const Text('Blood Group:',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                    horizontaSpace(20),
                    Container(
                      width:150,
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal:4,vertical: 4),
                      decoration: BoxDecoration(
                        
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black)
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value:value2,
                          iconSize: 36,
                          isExpanded:true,
                          icon:const Icon(Icons.arrow_drop_down,color: Colors.black,),
                          items: bloodgroups.map(buildMenuItem2).toList(),
                           onChanged: (value2)=>setState(() => this.value2=value2),

                          ),
                      ),
                    ),
                    ],
                  ),
                  verticalSpace(10),
                  // Row(
                  //   children: [
                  //     const SizedBox(height:20),
                  //      const Text('Cholestrol Level:',style: TextStyle(fontWeight: FontWeight.bold),),
                  //      SizedBox(
                  //       width: 50,
                  //       height: 30,
                  //       child: TextFormField(  
                  //                      keyboardType: TextInputType.number,
                  //                      decoration:const InputDecoration( 
                  //                      border: OutlineInputBorder(),
                  //                           ),
                  //                      validator: (value) {
                  //                             if (value!.isEmpty ) {
                  //                             ScaffoldMessenger.of(context).showSnackBar ( const SnackBar(content: Text('Invalid Measure.')));
                  //                             }
                  //                             return null;
                  //                             },
                  //                 ),
                  //      ),
                  //      horizontaSpace(20),
                  //  const Text('Sugar Level: ',style: TextStyle(fontWeight: FontWeight.bold),),
                  //  SizedBox(
                  //   width: 50,
                  //   height:30,
                  //   child: TextFormField(  
                  //                      keyboardType: TextInputType.number,
                  //                      decoration: const InputDecoration( 
                  //                      border: OutlineInputBorder(),
                  //                           ),
                  //                       validator: (value) {
                  //                             if (value!.isEmpty ) {
                  //                             ScaffoldMessenger.of(context).showSnackBar ( const SnackBar(content: Text('Invalid Measure.')));
                  //                             }
                  //                             return null;
                  //                             },
                  //                 ),
                  //  ),
                  //   ],
                  // ),
                  //  verticalSpace(20),
                     verticalSpace(20),
                      Row(

                        children: [
                           horizontaSpace(10),
                           const Text("Age :",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
        
                          ),
                          
                    Container(
  
                    padding:const EdgeInsets.only(top:0),
                    width: 200,
                    height:50,
                    child: TextFormField(  
                                           keyboardType: TextInputType.number,
                                           controller: _ageTEC,
                                           decoration:  InputDecoration( 
                                           hintText:'$age',
                                           helperText:'if no change let it blank',
                                           //border:const OutlineInputBorder(),
                                                 ),
                                          //  validator: (value) {
                                          //         if (value!.isEmpty ) {
                                          //         ScaffoldMessenger.of(context).showSnackBar ( const SnackBar(content: Text('Invalid Age')));
                                          //         }
                                          //         return null;
                                          //         },
                                      ),
                   ),
                        ],
                      ),
                  
                      verticalSpace(20),
                      Row(
                        children: [
                          horizontaSpace(10),
                          const Text("Height :",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                    SizedBox(
                                      width: 200,
                                      height:50,
                                      child: TextFormField(  
                                           keyboardType: TextInputType.number,
                                           controller: _heightTEC,
                                           decoration:  InputDecoration( 
                                           hintText:'$height',
                                           helperText:'if no change let it blank',
                                           //border:const OutlineInputBorder(),
                                                ),
                                                // validator: (value) {
                                                //   if (value!.isEmpty ) {
                                                //   ScaffoldMessenger.of(context).showSnackBar ( const SnackBar(content: Text('Invalid Height')));
                                                //   }
                                                //   return null;
                                                //   },
                                      ),
                   ),
                        ],
                      ),
                      verticalSpace(20),
                      
                          Row(
                            children: [
                              horizontaSpace(10),
                              const Text("Weight :",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                       
                                      SizedBox(
                                      width: 200,
                                      height:50,
                                      child: TextFormField(  
                                           keyboardType: TextInputType.number,
                                           controller:_weightTEC,
                                           decoration:  InputDecoration(
                                           hintText: '$weight',
                                           helperText:'if no change let it blank', 
                                           //border:const OutlineInputBorder(),
                                                ),
                                                // validator: (value) {
                                                //   if (value!.isEmpty ) {
                                                //   ScaffoldMessenger.of(context).showSnackBar ( const SnackBar(content: Text('Invalid Weight')));
                                                //   }
                                                //   return null;
                                                //   },
                                      ),
                   ),
                            ],
                          ),
                  
                  verticalSpace(20),
                  Row(
                    children: [
                      horizontaSpace(10),
                      const Text('Phone Number :',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                       Container(
                        width:150,
                        height: 60,
                        //padding: EdgeInsets.only(top:25),
                         decoration: BoxDecoration(
                          
                          borderRadius: BorderRadius.circular(12),
                          
                          //border: Border.all(color: Colors.black)
                          
                            ),                   
                         child: TextFormField(
                         
                         controller:_phoneTEC,
                         keyboardType: TextInputType.phone,
                         decoration:InputDecoration( 
                                  hintText:'$phone',
                                  helperText:'if no change let it blank',
                                  //border: const OutlineInputBorder(),
                                            ),
                        //  validator: (value) {
                        //                       if (value!.isEmpty ) {
                        //                       return 'Enter a valid Phone number!';
                        //                       }
                        //                       return null;
                        //                       },
                                       ),
                                       
                       ),
                    ],
                  ),
                  verticalSpace(20),
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child:ElevatedButton(onPressed:(){
                      var wght;
                      var hgt;
                      var ag;
                     var phn;
                      //var name=_nameTEC.text;
                      //var email=_emailTEC.text;
                      
                      if(_weightTEC.text.isEmpty){
                      wght=weight;
                    
                      }else{
                        //print('Exception');
                        //print(_weightTEC.text);
                        wght=double.parse(_weightTEC.text);
                      }
                      if(_heightTEC.text.isEmpty){
                      hgt=height;
                    
                      }else{
                        //print('Exception');
                        //print(_heightTEC.text);
                        hgt=double.parse(_heightTEC.text);
                      }
                      if(_phoneTEC.text.isEmpty){
                      phn=phone;
                    
                      }else{
                        //print('Exception');
                        //print(_heightTEC.text);
                        phn=_phoneTEC.text;
                      }
                      if(_ageTEC.text.isEmpty){
                      ag=age;
                    
                      }else{
                        //print('Exception');
                        //print(_heightTEC.text);
                        ag=int.parse(_ageTEC.text);
                      }
                      
                      var bg=value2.toString();
                      
                       

                      print("Weight: $wght");
                      print("Height: $hgt");
                      print("phone:"+phn);
                      print("age: $age");
                      print("bloodgroups "+bg);
                      //final isValid = _key.currentState!.validate();
                      // if (!isValid) {
                      //      return ;
                      //  }
                     //_key.currentState!.save();
                     // else{
                      editUserData(age:ag,bg:bg,phone:phn,height:hgt,weight:wght);
                      Future.delayed(const Duration(seconds: 1), ()
                     {
                      //ScaffoldMessenger.of(context).showSnackBar ( const SnackBar(content: Text('Updating... ')));
                      navigatorKey?.currentState?.pushReplacementNamed("homescreen");
                      //Navigator.popUntil(context, (route) => route.isFirst);
                      });
                  
                      
                               
                    },
                     child:const Text(" Submit ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                     ),
                  ),
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

// //gender
// DropdownMenuItem<String>buildMenuItem(String item) => DropdownMenuItem(
//   value:item,
//   child:Text(
//     item,
//     style:const TextStyle(fontSize: 20,fontWeight:FontWeight.bold)
//   )
// );


DropdownMenuItem<String>buildMenuItem2(String item) => DropdownMenuItem(
  value:item,
  child:Text(
    item,
    style:const TextStyle(fontSize: 20,fontWeight:FontWeight.bold)
  )
);

