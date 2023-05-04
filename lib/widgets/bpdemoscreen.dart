import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BpDemoChart extends StatelessWidget {
  const BpDemoChart({
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
              LineSeries<ChartData, dynamic>(
                  dataSource: [
                      // Bind data source
                      ChartData('Jan 1', 35),
                      ChartData('Jan 2', 28),
                      ChartData('Jan 3', 34),
                      ChartData('Jan 4', 32),
                      ChartData('Jan 5', 40)
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
