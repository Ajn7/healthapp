import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthapp/constants/divider.dart';
//import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
DateTime _selectedDate=DateTime.now();
//DateTime _selectedDate=DateTime.now();
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

  // @override
  // void initState() {
  //   super.initState();
  //   _resetSelectedDate();
  // }

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
            // Padding(
            //   padding: const EdgeInsets.all(16),
            //   child: Text(
            //     'Calendar ',
            //     style: Theme.of(context)
            //         .textTheme
            //         .headline6!
            //         .copyWith(color:Colors.black ),//Colors.tealAccent[100]
            //   ),
            // ),
            CalendarTimeline(
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
            const SizedBox(height: 20),
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
            const SizedBox(height: 20),
            Center(
              child: Text(
                'Selected date is $_selectedDate',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              height:300,
              width:300,
              child:Meas()
            )
            
          ],
        ),
      ),
    );
  }
}

var value=100;
class ChartData {
  var x;
  double open;
  double high;
  double low;
  
  //double close;

  ChartData({required this.x,required this.open,required this.high,required this.low});
}

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
              Text('Previous Reading: $value \n$_selectedDate ',style: TextStyle(color:Colors.green,fontSize: 18),),
              verticalSpace(20),
              Text('Blood Pressure',style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold),),
                SizedBox(
                  height: 200,
                  width: 400,
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
            ],
                    ),
        )
    );
    
  }
}

