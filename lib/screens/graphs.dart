import 'package:flutter/material.dart';
import '../constants/headline.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';
class Graphscreen extends StatefulWidget {
   const Graphscreen({super.key});

   // Generate some dummy data for the cahrt
  // This will be used to draw the red line
  
  @override
  State<Graphscreen> createState() => _GraphscreenState();
}

class _GraphscreenState extends State<Graphscreen> {
  
 //Map<int,int> Spo={1:2,6:5,3:5};
 
//List<FlSpot> dummyData1 =Spo.values.toList();
//List<int> value=[1,2,3,4];
// double a=2;
// double b=5;
  final List<FlSpot> dummyData1 = List.generate(8, (index) {
    return FlSpot(index.toDouble(), index * Random().nextDouble());

  });
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child:Column(
            children: [
              headline(),
              Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        height: 300,
        child: LineChart(
          LineChartData(
            borderData: FlBorderData(show: false),
           lineBarsData: [
            LineChartBarData(
              spots:dummyData1,
               //[ 
              // const FlSpot(0, 1),
              // const FlSpot(1, 3),
              // const FlSpot(2, 10),
              // const FlSpot(3, 7),
              // const FlSpot(4, 12),
              // const FlSpot(5, 13),
              // const FlSpot(6, 17),
              // const FlSpot(7, 15),
              // const FlSpot(8, 20)
            //],
            isCurved: true,
            barWidth: 3,
            color: Colors.green,
            )
          ]
          ),
          swapAnimationDuration: Duration(milliseconds: 150),
        ),
),
            ],
    ),
   ),
  );
 }
}
