import 'package:flutter/material.dart';
import 'package:healthapp/constants/divider.dart';
import 'package:healthapp/screens/Sample.dart';
//import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

  //decode
  List<double> val = [1,2,3,4];
  var value=100;
class ChartData {
  var x;
  double open;
  double high;
  double low;
  
  //double close;

  ChartData({required this.x,required this.open,required this.high,required this.low});
}

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
          appBar: AppBar(backgroundColor: Colors.blue,
          title: const Text('HealthConnect',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold))),
          body: SafeArea(
            child:Column(
            children: [
              //headline(),
              verticalSpace(30),
              Text('Previous Reading: $value',style: TextStyle(color:Colors.green,fontSize: 18),),
              verticalSpace(20),
              Text('Blood Pressure',style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold),),
                SizedBox(
                  height: 300,
                  width: 300,
                  child: ListView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 3,
                      child:  SfCartesianChart(
                      primaryXAxis: DateTimeAxis(),
                      series: <ChartSeries>[
                          // Renders bar chart
                          HiloSeries<ChartData, DateTime>(
                              dataSource:<ChartData>[
                              ChartData( // Open and close values are same
                                  x:  DateTime.now(),
                                  open: 86.3593,
                                  high: 88.1435,
                                  low: 84.3914,
                                 // close: 86.3593
                                 ),
                              ChartData( // High and low values are same
                                  x:  DateTime.parse('2022-02-20 20:18:04Z'),
                                  open: 80,
                                  high: 120,
                                  low: 50,
                                  //close: 87.001
                                  ),
                              ChartData( //High, low, open, and close values all are same
                                  x:  DateTime.parse('2021-07-20 20:18:04Z'),
                                  open: 50,
                                  high: 86,
                                  low: 20,
                                  //close: 86.4885
                                  ),
                                  ChartData( //High, low, open, and close values all are same
                                  x:  DateTime.parse('2021-01-20 20:18:04Z'),
                                  open: 50,
                                  high: 86,
                                  low: 20,
                                  //close: 86.4885
                                  ),
                          ],
                              xValueMapper: (ChartData data, _) => data.x,
                              lowValueMapper: (ChartData data, _) => data.low,
                              highValueMapper: (ChartData data, _) => data.high
                          )
                      ]
                  ),
                    )
                    ),
                  ],
                          ),
                ),
              
             TextButton(child: Text("forgot your password?",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:Colors.red.shade400, decoration: TextDecoration.underline),),
                onPressed:(){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => BPScreen()));
                }, ),
            ],
                    ),
        )
    );
    
  }
}

