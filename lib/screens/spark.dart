import 'package:flutter/material.dart';
import '../constants/headline.dart';
import 'package:chart_sparkline/chart_sparkline.dart';


class Sparklinescreen extends StatefulWidget {
  Sparklinescreen({super.key});
  List<double> data = [0.0, 1.0, 1.5, 2.0, 1.0, 0.5, 1.5, 2.0];
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
                child: Sparkline(
                     data: [1,2,3,3,5,2,1,3,4,4,2,1,7,4],
                     lineWidth: 5.0,
                     lineColor: Colors.purple,
                      ),
              )
             
            ],
          ),
        )
    );
    
  }
}


