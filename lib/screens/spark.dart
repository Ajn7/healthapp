import 'package:flutter/material.dart';
import '../constants/headline.dart';
import 'package:chart_sparkline/chart_sparkline.dart';

  //decode
  List<double> val = [1,2,3,4];
  

class Sparklinescreen extends StatefulWidget {
  Sparklinescreen({super.key});
  @override
  State<Sparklinescreen> createState() => _SparklinescreenState();
}

class _SparklinescreenState extends State<Sparklinescreen> {
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child:Column(
            children: [
              headline(),
              Container(
                height: 100,
                width:100,
                child: Sparkline(
                     data: val,
                      lineWidth: 7.0,
                      lineGradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.purple,Colors.red]
                      ),
                ),
              )
             
            ],
          ),
        )
    );
    
  }
}


