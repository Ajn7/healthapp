import 'package:flutter/material.dart';

import '../constants/divider.dart';
import '../core/navigator.dart';
import '../widgets/measurebutton.dart';



class GraphButton extends StatelessWidget {
  final Widget w1;
  final String routName;
  const GraphButton({
    required this.w1,
    required this.routName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container (
    color: Colors.white,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children:  [
          SizedBox(
          height: 200,
          width: 250 ,
      child:  w1,
      
     ),
       horizontaSpace(20),
     MeasureButton(buttonText: 'Measure', buttonAction: () { 
         // getData();
          //Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const BPScreen()));
         navigatorKey?.currentState?.pushNamed(routName);  
        }),   
        
      ],
    ),
     
    );
  }
}