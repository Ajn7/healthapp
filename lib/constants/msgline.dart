import 'package:flutter/material.dart';

Widget msgLine({message:String}){
  return Align(
   alignment: Alignment.topCenter,
   child:Padding(
    padding: EdgeInsets.only(bottom: 20),
    child:Text('$message',style: TextStyle(color:Colors.black,fontSize: 35,fontWeight: FontWeight.bold)),)
);

}

Widget VerticalSpace(double value) {
  if (value < 0) {
    value = 0;
  }
  return SizedBox(height: value);
}

Widget HorizontaSpace(double value) {
  if (value < 0) {
    value = 0;
  }
  return SizedBox(width: value);
}

