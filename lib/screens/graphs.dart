import 'package:flutter/material.dart';
import '../constants/headline.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
class Graphscreen extends StatefulWidget {
   const Graphscreen({super.key});
  @override
  State<Graphscreen> createState() => _GraphscreenState();
}

class _GraphscreenState extends State<Graphscreen> {
  
 //Map<int,int> Spo={1:2,6:5,3:5};
 
//List<FlSpot> dummyData1 =Spo.values.toList();
//List<int> value=[1,2,3,4];
// double a=2;
// double b=5;
  
  late TooltipBehavior _tooltipBehavior;

    @override
    void initState(){
      _tooltipBehavior =  TooltipBehavior(enable: true);
      super.initState(); 
    }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(title: const Text('HealthConnect',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold))),
          body: SafeArea(
            child:Column(
            children: [
              //headline(),
            Text('Previo Reading :'),
             SizedBox(
              width: 300,
              height: 300,
               child: Expanded(
                 child: ListView(
                   physics: BouncingScrollPhysics(),
                   scrollDirection: Axis.horizontal,
                   children:[ 
                    Container(
              
                          child: SfCartesianChart(
                              // Initialize category axis
                              title:  ChartTitle(
                              text: 'SPO2',
                              //backgroundColor: Colors.lightGreen,
                              //borderColor: Colors.blue,
                              //borderWidth: 2,
                              // Aligns the chart title to left
                              alignment: ChartAlignment.center,
                              textStyle:const TextStyle(
                              color: Colors.red,
                              fontFamily: 'Roboto',
                              fontStyle: FontStyle.italic,
                              fontSize: 20,)
                               ),
                               // Enables the tooltip for all the series in chart
                              tooltipBehavior: _tooltipBehavior,
                              primaryXAxis: CategoryAxis(),
                              series: <ChartSeries>[
                                  // Initialize line series
                                  LineSeries<ChartData, String>(
                                      dataSource: [
                                          // Bind data source
                                          ChartData('Jan', 100),
                                          ChartData('Feb', 99),
                                          ChartData('Mar', 80),
                                          ChartData('Apr', 72),
                                          ChartData('May', 60)
                                      ],
                                      xValueMapper: (ChartData data, _) => data.x,
                                      yValueMapper: (ChartData data, _) => data.y,
                                      dataLabelSettings:const DataLabelSettings(isVisible : true)
                                  )
                              ]
                          )
                      ),
                   ],
                 ),
               ),
             )
            ],
    ),
   ),
  );
 }
}
 class ChartData {
        ChartData(this.x, this.y);
        final String x;
        final double? y;
    }



//import 'package:fl_chart/fl_chart.dart';
//import 'dart:math';

// final List<FlSpot> dummyData1 = List.generate(8, (index) {
//     return FlSpot(index.toDouble(), index * Random().nextDouble());

//   });
// Container(
//         padding: const EdgeInsets.all(10),
//         width: double.infinity,
//         height: 300,
//         child: LineChart(
//           LineChartData(
//             borderData: FlBorderData(show: false),
//            lineBarsData: [
//             LineChartBarData(
//               spots:dummyData1,
//                //[ 
//               // const FlSpot(0, 1),
//               // const FlSpot(1, 3),
//               // const FlSpot(2, 10),
//               // const FlSpot(3, 7),
//               // const FlSpot(4, 12),
//               // const FlSpot(5, 13),
//               // const FlSpot(6, 17),
//               // const FlSpot(7, 15),
//               // const FlSpot(8, 20)
//             //],
//             isCurved: true,
//             barWidth: 3,
//             color: Colors.green,
//             )
//           ]
//           ),
//           swapAnimationDuration: Duration(milliseconds: 150),
//         ),
// ),