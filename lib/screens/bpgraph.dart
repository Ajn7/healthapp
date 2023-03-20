import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthapp/API/model.dart';
import 'package:healthapp/constants/divider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
DateTime _selectedDate=DateTime.now();
DataStore dataStore = DataStore();
class BPScreen extends StatelessWidget {
  const BPScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //late DateTime _selectedDate;

@override
  void initState() {
    super.initState();
   _selectedDate=DateTime.now();
  }

  // void _resetSelectedDate() {
  //   _selectedDate = DateTime.now();//.add(const Duration(days: 2));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white, //const Color(0xFF333A47),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            verticalSpace(10),
            Container(
              height: 140,
              margin: const EdgeInsets.all(10.0),
              //color: Color.fromARGB(255, 103, 199, 228),
              //transform: Matrix4.rotationZ(0.1),
              //width: 300,
              child: CalendarTimeline(
                showYears: true,
                initialDate: _selectedDate,
                firstDate: DateTime(2023, 1, 20),//DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365 * 4)),
                onDateSelected: (date) => setState(() => _selectedDate = date),
                leftMargin: 20,
                monthColor: Colors.blue,//Colors.white70
                dayColor: Colors.teal[200],
                dayNameColor:Colors.black,// const Color(0xFF333A47
                activeDayColor: Colors.white,
                activeBackgroundDayColor: Colors.redAccent[100],
                dotsColor: const Color(0xFF333A47),
                //selectableDayPredicate: (date) => date.day != 23,
                locale: 'en',
              ),
            ),
            //const SizedBox(height: 20),
            // Padding(
            //   padding: const EdgeInsets.only(left: 16),
            //   child: TextButton(
            //     style: ButtonStyle(
            //       backgroundColor: MaterialStateProperty.all(Colors.teal[200]),
            //     ),
            //     child: const Text(
            //       'RESET',
            //       style: TextStyle(color: Color(0xFF333A47)),
            //     ),
            //     onPressed: () => setState(() => _resetSelectedDate()),
            //   ),
            // ),
            horizontaSpace(10),
            Center(
              child: Text(
                'Selected date is $_selectedDate',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              height:484,
              width:300,
              child:Meas()
            )
            
          ],
        ),
      ),
    );
  }
}

var value=dataStore.dta.last;
class Meas extends StatefulWidget {
  Meas({super.key});
  @override
  State<Meas> createState() => _MeasState();
}

class _MeasState extends State<Meas> {
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child:Column(
            children: [
              //headline(),
              Text('Previous Reading: $value \n$_selectedDate ',style: const TextStyle(color:Colors.green,fontSize: 18),),
              verticalSpace(20),
              const Text('Blood Pressure',style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold),),
                SizedBox(
                  height: 400,
                  width: 300,
                  child: ListView(
                  physics:const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child:SizedBox(
                      width: MediaQuery.of(context).size.width * 3,
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
                            //tooltipBehavior: _tooltipBehavior,
                            primaryXAxis: CategoryAxis(),
                            primaryYAxis: NumericAxis(                 
                              minimum: 30, 
                              maximum: 100, 
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
                                getDataSp()
                            ]
                        ) 
                    )
                    ),
                  ],
                          ),
                ),
            ],
                    ),
        )
    );
    
  }
}

// SfCartesianChart(
//                       primaryXAxis: DateTimeAxis(),
//                       series: <ChartSeries>[
//                           // Renders bar chart
//                           HiloSeries<ChartData, DateTime>(
//                               dataSource:<ChartData>[
//                               ChartData( // Open and close values are same
//                                   x:  DateTime.now(),
//                                   open: 86.3593,
//                                   high: 88.1435,
//                                   low: 84.3914,
//                                  // close: 86.3593
//                                  ),
//                               ChartData( // High and low values are same
//                                   x:  DateTime.parse('2022-02-20 20:18:04Z'),
//                                   open: 80,
//                                   high: 120,
//                                   low: 50,
//                                   //close: 87.001
//                                   ),
//                               ChartData( //High, low, open, and close values all are same
//                                   x:  DateTime.parse('2021-07-20 20:18:04Z'),
//                                   open: 50,
//                                   high: 86,
//                                   low: 20,
//                                   //close: 86.4885
//                                   ),
//                                   ChartData( //High, low, open, and close values all are same
//                                   x:  DateTime.parse('2021-01-20 20:18:04Z'),
//                                   open: 50,
//                                   high: 86,
//                                   low: 20,
//                                   //close: 86.4885
//                                   ),
//                           ],
//                               xValueMapper: (ChartData data, _) => data.x,
//                               lowValueMapper: (ChartData data, _) => data.low,
//                               highValueMapper: (ChartData data, _) => data.high
//                           )
//                       ]
//                   ),

SplineSeries<ChartData, String> getDataSp() {

  List<ChartData> spData=[];

    int i;
    //List<String>mnth=['jan','feb','mar','apr','may','jun','jul','aug','sep','oct','nov','dec'];
    // List<double>dt=[80,90,92,95,92,85,91,94,93,87,88,30];
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

    for(i=0;i<(dataStore.tme).length;i++){
      spData.add(ChartData(dataStore.tme[i].toString(),dataStore.dta[i].toDouble()));
    }

  return SplineSeries<ChartData, String>(

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