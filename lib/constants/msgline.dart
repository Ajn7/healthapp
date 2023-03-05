import 'package:flutter/material.dart';

Widget msgLine({message:String}){
  return Align(
   alignment: Alignment.topCenter,
   child:Padding(
    padding:const EdgeInsets.only(bottom: 20),
    child:Text('$message',style:const TextStyle(color:Colors.black,fontSize: 35,fontWeight: FontWeight.bold)),)
);

}



