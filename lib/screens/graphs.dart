import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
class Graphscreen extends StatefulWidget {
   const Graphscreen({super.key});
  @override
  State<Graphscreen> createState() => _GraphscreenState();
}

class _GraphscreenState extends State<Graphscreen> {
  
 //Map<int,int> Spo={1:2,6:5,3:5};
 

  
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
            const Text('Previo Reading :'),
             SizedBox(
              width: 300,
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
                            series: <ChartSeries>[
                                getData()
                            ]
                        )
                    ),
                 ],
               ),
             )
            ],
    ),
   ),
  );
 }
}
 

LineSeries<ChartData, String> getData() {

  List<ChartData> spData=[];

    int i;
    List<String>mnth=['jan','feb','mar','apr','may','jun','jul','aug','sep','oct','nov','dec'];
    List<double>dt=[10,20,30,40,50,60,70,80,90,100,110,120];
    for(i=0;i<dt.length;i++){
      spData.add(ChartData(mnth[i],dt[i]));
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
