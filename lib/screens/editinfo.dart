import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../API/model.dart';
import '../constants/divider.dart';
// import '../constants/msgline.dart';
import '../core/navigator.dart';
import '../API/apicalls.dart';

DataStore dataStore = DataStore();

class EditInfo extends StatefulWidget{
  
  const EditInfo({super.key});
  @override
  State<EditInfo> createState()=>_EditInfo();

}



class _EditInfo extends State<EditInfo> with API{
  final GlobalKey<FormState> _key = GlobalKey();
  final bloodgroups=['A+ve','A-ve','B+ve','B-ve','O+ve','O-ve'];
  String?value1;
  String?value2=dataStore.bloodgroup;
  final TextEditingController _phoneTEC=TextEditingController();
  final TextEditingController _weightTEC=TextEditingController();
  final TextEditingController _heightTEC=TextEditingController();
  final TextEditingController _ageTEC=TextEditingController();
   @override
    void initState(){
      //print('image:${dataStore.image.toString().substring(5)}');
      super.initState(); 
      
    }
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title:const Text("Edit Profile Information")),
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
                  //msgLine(message: "Edit Profile"),
                  
                  (dataStore.image!='')?
                    ClipOval(
                      child: Image.file(
                        File(dataStore.image),
                        fit: BoxFit.cover, 
                        width: 160,
                        height: 160,
                        ),
                  ):const Text('No Image'),
                //    Image.asset(
                //   'assets/images/login.png', //
                //       height: 150,
                //       width: 200,
                //     //color: Colors.red,
                //       colorBlendMode: BlendMode.darken,
                // ),
                TextButton( 
                  onPressed: () async {
                  final pickedFile = await ImagePicker().pickImage(
                  source: ImageSource.gallery, // or ImageSource.camera
                  );
                  try{
                  setState(() {
                  dataStore.image = File(pickedFile!.path).path;
                  //img=dataStore.image;
                  print('img: ${dataStore.image}');
                  });
                  }catch(e) {
                    print(e);
                  }
                  
                },
                child: const Text('Change Photo')
                ),
                
                  
                  verticalSpace(20),
                  
                  Row(
                   // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [ 
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
                          icon:const Icon(
                            Icons.arrow_drop_down,color: Colors.black,
                            ),
                          items: bloodgroups.map(buildMenuItem2).toList(),
                           onChanged: (value2)=>setState(() => this.value2=value2),

                          ),
                      ),
                    ),
                    ],
                  ),
                  verticalSpace(10),                
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
                                           hintText:'${dataStore.age}',
                                           helperText:'if no change let it blank',                                          
                                                 ),
                                         
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
                                           hintText:'${dataStore.height}',
                                           helperText:'if no change let it blank',                                         
                                                ),
                                               
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
                                           hintText: '${dataStore.weight}',
                                           helperText:'if no change let it blank',                                           
                                                ),
                                               
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
                                  hintText:dataStore.phone,
                                  helperText:'if no change let it blank',
                                  //border: const OutlineInputBorder(),
                                            ),
                      
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
                     
                      
                      if(_weightTEC.text.isEmpty){
                      wght=dataStore.weight;
                    
                      }else{
                        
                        wght=double.parse(_weightTEC.text);
                      }
                      if(_heightTEC.text.isEmpty){
                      hgt=dataStore.height;
                    
                      }else{
                        //print('Exception');
                        //print(_heightTEC.text);
                        hgt=double.parse(_heightTEC.text);
                      }
                      if(_phoneTEC.text.isEmpty){
                      phn=dataStore.phone;
                    
                      }else{
                        //print('Exception');
                        //print(_heightTEC.text);
                        phn=_phoneTEC.text;
                      }
                      if(_ageTEC.text.isEmpty){
                      ag=dataStore.age;
                    
                      }else{
                        //print('Exception');
                        //print(_heightTEC.text);
                        ag=int.parse(_ageTEC.text);
                      }
                      
                      var bg=value2.toString();
                      
                       

                      print("Weight: $wght");
                      print("Height: $hgt");
                      print("phone:"+phn);
                      print("age: ${dataStore.age}");
                      print("bloodgroups "+bg);
                     
                      editUserData(age:ag,bg:bg,phone:phn,height:hgt,weight:wght,image:dataStore.image);
                      Future.delayed(const Duration(seconds: 1), ()
                     {
                      
                      navigatorKey?.currentState?.pushReplacementNamed("homescreen");
                     
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



DropdownMenuItem<String>buildMenuItem2(String item) => DropdownMenuItem(
  value:item,
  child:Text(
    item,
    style:const TextStyle(fontSize: 20,fontWeight:FontWeight.bold)
  )
);

