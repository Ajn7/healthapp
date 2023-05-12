import 'package:flutter/material.dart';
//import 'package:animated_text_kit/animated_text_kit.dart'; 


Widget headline(){
  return const Align(
   alignment: Alignment.topCenter,
   child:Padding(
    padding: EdgeInsets.only(top:106),
    child:Text(
      'HealthConnect',
      style: TextStyle(color:Color(0xFFB80075),
      fontSize: 40,fontWeight: FontWeight.bold),
      ),
      ),
      
);

}




// TextLiquidFill(
//       boxHeight: 50,      
//       text:'HealthConnect',
//       waveColor: Color(0xFFB80075),
//       //boxBackgroundColor: Colors.transparent,
//       textStyle:const TextStyle(
//       fontSize: 40,fontWeight: FontWeight.bold),
//       ),
