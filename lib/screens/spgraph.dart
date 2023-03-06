import 'package:flutter/material.dart';
import 'package:healthapp/API/model.dart';
import 'package:healthapp/widgets/measurebutton.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
class SpoGraphscreen extends StatefulWidget {
   const SpoGraphscreen({super.key});
  @override
  State<SpoGraphscreen> createState() => _SpoGraphscreenState();
}

List<dynamic>data=dta;
List<dynamic>time=tme;

class _SpoGraphscreenState extends State<SpoGraphscreen> {
  DateTime date=DateTime.now();
  //api call

  // late TooltipBehavior _tooltipBehavior;

    // @override
    // void initState(){
    //     //getReading();
    //   // _tooltipBehavior =  TooltipBehavior(
    //   //   header: "",
    //   //   enable: true,
    //   //   format: 'point.x : point.y%',
    //   //   canShowMarker: false,
    //   // );
    //   super.initState(); 
    // }

  @override
  Widget build(BuildContext bcontext) {
    //final TextEditingController _times=TextEditingController();
    final TextEditingController _value=TextEditingController();
    prev=data.last;
    print('Previos reading data : $prev');
    return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(title: const Text('HealthConnect',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold))),
          body: SingleChildScrollView(
            child: SafeArea(
              child:Column(
              children: [
                InkWell(
                  onTap:()async{
                        DateTime?newDate=await showDatePicker(context: context, 
                        initialDate:date,
                        firstDate: DateTime(2012),
                        lastDate: DateTime(2025)
                        );
                        
                        //check
                        if(newDate==null){
                        return;
                                  }
                        if(newDate.compareTo(DateTime.now())>0)
                        {
                        ScaffoldMessenger.of(bcontext).showSnackBar (const SnackBar(content: Text('Data Unavailable')));
                        return;
                        }
                        setState(() {
                        date=newDate;
                                  }
                                );                                           
                        },
                  child: Row(
                    children: [
                      const Padding(
                        padding:EdgeInsets.only(left:20,top: 20,right: 8),
                        child: Icon(
                        size: 40,
                        color: Colors.blue,
                        Icons.edit_calendar_outlined
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:20.0,right: 10),
                        child: Text(
                        '${date.day} /${date.month} /${date.year}',
                        style: const TextStyle(fontSize: 18,color: Color(0xFF0b5345),fontWeight:FontWeight.bold),
                        ),
                      ),                           
                    ],
                  ),
                ),
                Padding(              
                            padding:const EdgeInsets.only(top: 10),
                            child:Text('Previous Reading : $prev',textAlign: TextAlign.center,style:const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                            
                            ),
              const GScreen(),
              // SizedBox(
              //   height: 50,
              //   width: 200,
              //   child: TextFormField(
              //          controller:_times,
              //         keyboardType: TextInputType.datetime,
              //         decoration: const InputDecoration( 
              //                    border: OutlineInputBorder(),
              //                    prefixIcon: Icon(Icons.access_time),
              //                    hintText: "Time Here",
              //                    hintStyle: TextStyle(fontSize: 20.0, ),
              //                    //labelText: "Last Name",
              //                    //labelStyle: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
              //                              ),
              //         //           validator: (value) {
              //         //           if (value!.isEmpty) {
              //         //           return 'Enter a last name!';
              //         //           }
              //         //           return null;
              //         //           },
              //                        ),
              // ),
               SizedBox(
                height: 50,
                width: 200,
                 child: TextFormField(
                       controller:_value,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration( 
                                 border: OutlineInputBorder(),
                                 prefixIcon: Icon(Icons.add_circle_outline),
                                 hintText: "Enter SPO2 Here",
                                 hintStyle: TextStyle(fontSize: 20.0, ),
                                 //labelText: "Last Name",
                                 //labelStyle: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                                           ),
                      //           validator: (value) {
                      //           if (value!.isEmpty) {
                      //           return 'Enter a last name!';
                      //           }
                      //           return null;
                      //           },
                                     ),
               ),
              MeasureButton(buttonText: 'Add', buttonAction: (){
                setState(() {
                double d=double.parse(_value.text);
                var s=DateTime.now();
                //print(s.day);
                //print(s.month);
                //print(s.year);                
                //print((s.day).toString());
                // const year = now.getFullYear();     // e.g. 2023
                // month = now.getMonth() + 1;   // e.g. 3 (note: months are zero-indexed)
                // const date = now.getDate();         // e.g. 4
                // const hours = now.getHours();       // e.g. 10
                // const minutes = now.getMinutes();   // e.g. 30
                // const seconds = now.getSeconds(); 
                data.add(d);
                time.add(s.toString());
                Navigator.pushReplacement(
                bcontext,
                MaterialPageRoute(
                builder: (BuildContext context) => super.widget));
                });
                
              })             
              ],
              ),
             ),
          ),
  );
 }
}
 
class GScreen extends StatefulWidget {
  const GScreen({super.key});
  
  @override
  State<GScreen> createState() => _GScreenState();
}

class _GScreenState extends State<GScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
     _tooltipBehavior =  TooltipBehavior(
        header: "",
        enable: true,
        format: 'point.x : point.y%',
        canShowMarker: false,
      );
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
              padding:const EdgeInsets.only(left:40,right:30,top:10),
              //width: 800,
              height: 300,
               child: ListView(
                 physics:const BouncingScrollPhysics(),
                 scrollDirection: Axis.horizontal,
                 children:[ 
                  SizedBox(                                
                        child: SfCartesianChart(
                            // Initialize category axis
                            title:  ChartTitle(
                            text: 'Oxygen Saturation',
                            //backgroundColor: Colors.lightGreen,
                            //borderColor: Colors.blue,
                            //borderWidth: 2,
                            // Aligns the chart title to left
                            alignment: ChartAlignment.center,
                            textStyle:const TextStyle(
                            color: Colors.red,
                            fontFamily: 'Roboto',
                            //fontStyle: FontStyle.italic,
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
             );
    
  }
}
SplineSeries<ChartData, String> getData() { //SplineSeries

  List<ChartData> spData=[];

    int i;
    //List<String>mnth=['jan','feb','mar','apr','may','jun','jul','aug','sep','oct','nov','dec'];
    // List<double>dt=[80,90,92,95,92,85,91,94,93,87,88,50];
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

    for(i=0;i<time.length;i++){
      spData.add(ChartData(time[i].toString(),data[i].toDouble()));
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

//cupertino date picker - import 'package:flutter/cupertino.dart';
// class CalenderScreen extends StatefulWidget {
//   const CalenderScreen({super.key});
//   @override
//   State<CalenderScreen> createState() => _CalenderScreenState();
// }

// class _CalenderScreenState extends State<CalenderScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SizedBox(
//                   height: 200,
//                   child: CupertinoDatePicker(
//                     mode: CupertinoDatePickerMode.date,
//                     initialDateTime: DateTime.now(),
//                     onDateTimeChanged: (DateTime newDateTime) {
//                       print(newDateTime);
//                     },
//                   ),
//                 ),
//       ),
//     );
//   }
// }