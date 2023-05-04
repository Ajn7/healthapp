import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class OxygenHomeDemoChart extends StatelessWidget {
  const OxygenHomeDemoChart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
    // Enables the legend
     // legend: Legend(isVisible: true),
    //title: ChartTitle(text: ' analysis'),
      // Initialize category axis
      //tooltipBehavior: _tooltipBehavior,
      primaryXAxis: CategoryAxis(),
      series: <ChartSeries>[
          // Initialize line series
          AreaSeries<ChartData, dynamic>(
           color: Colors.blue[200],
           
               borderColor: Colors.red,
               borderWidth: 2,
              dataSource: [
               
                  // Bind data source
                  ChartData('Jan 1', 94),
                  ChartData('Jan 2', 94),
                  ChartData('Jan 3', 96),
                  ChartData('Jan 4', 95),
                  ChartData('Jan 5', 98),
                   ChartData('.....', 99),
              ],
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,
              // Render the data label
              dataLabelSettings:const DataLabelSettings(isVisible : true)
          )
      ]
                   );
  }
}



class ChartData {
        ChartData(this.x, this.y);
        final dynamic x;
        final double? y;
    }