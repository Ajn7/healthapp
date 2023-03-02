import 'package:flutter/material.dart';
import 'package:healthapp/API/model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
class Graphscreen extends StatefulWidget {
   const Graphscreen({super.key});
  @override
  State<Graphscreen> createState() => _GraphscreenState();
}

class _GraphscreenState extends State<Graphscreen> {
  
  //api call
  

 

  
  late TooltipBehavior _tooltipBehavior;

    @override
    void initState(){
        //getReading();
      _tooltipBehavior =  TooltipBehavior(
        header: "",
        enable: true,
        format: 'point.x : point.y%',
        canShowMarker: false,
      );
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
            const Text('Previous Reading :'),
             SizedBox(
              width: 500,
              height: 300,
               child: ListView(
                 physics:const BouncingScrollPhysics(),
                 scrollDirection: Axis.horizontal,
                 children:[ 
                  SizedBox(
              
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
                            primaryYAxis: NumericAxis(                 
                              minimum: 50, 
                              maximum: 120, 
                              interval: 5,
                              // title: AxisTitle(
                              //   text: 'SPO2%',
                              //   textStyle:const TextStyle(
                              //       color: Colors.deepOrange,
                              //       fontFamily: 'Roboto',
                              //       fontSize: 16,
                              //       fontStyle: FontStyle.italic,
                              //       fontWeight: FontWeight.w300
                              //   ),
                              // ),
                            ),
                            series: <ChartSeries>[
                                getData()
                            ]
                        )
                    ),
                 ],
               ),
             ),
            ],
    ),
   ),
  );
 }
}
 

LineSeries<ChartData, String> getData() {

  List<ChartData> spData=[];

    int i;
    //List<String>mnth=['jan','feb','mar','apr','may','jun','jul','aug','sep','oct','nov','dec'];
    //List<double>dt=[80,90,92,95,92,85,91,94,93,87,88,95];
    // List<String>dte=[
    // '01:00', 
    // '01:15', 
    // '01:20', 
    // '01:25',
    // '01:30',
    // '01:35',
    // '01:40',
    // '01:45',
    // '01:50',
    // '01:55',
    // '01:57',
    // '01:60'];

    for(i=0;i<dte.length;i++){
      spData.add(ChartData(dte[i].toString(),dt[i].toDouble()));
    }

  return LineSeries<ChartData, String>(

    // Create a new LineSeries object
    dataSource:spData,
    xValueMapper: (ChartData data, _) => data.x, // Map x values to ChartData.x
    yValueMapper: (ChartData data, _) => data.y, // Map y values to ChartData.y
    dataLabelSettings:const DataLabelSettings(isVisible : true)

  );

}

class ChartData {
        ChartData(this.x, this.y);
        final String x;
        final double? y;
    }
