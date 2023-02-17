import 'package:flutter/material.dart';

Widget msgLine({message:String}){

  return Align(
   alignment: Alignment.topCenter,
   child:Padding(
    padding: EdgeInsets.only(bottom: 20),
    child:Text('$message',style: TextStyle(color:Colors.black,fontSize: 35,fontWeight: FontWeight.bold)),)
);

}



