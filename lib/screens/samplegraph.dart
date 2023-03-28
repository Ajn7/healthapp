import 'package:flutter/material.dart';
import 'package:healthapp/API/model.dart';
import 'package:healthapp/API/apicalls.dart';
import 'package:healthapp/constants/divider.dart';
import 'package:healthapp/widgets/measurebutton.dart';
//import 'package:syncfusion_flutter_charts/charts.dart';
DataStore dataStore=DataStore();
bool isvisible=true;
DateTime today=DateTime.now();
 int len=dataStore.dta.length;
 List<Widget> widgets = [];
class SampleGraphScreen extends StatefulWidget {
   const SampleGraphScreen({super.key});
  @override
  State<SampleGraphScreen> createState() => _SampleGraphScreenState();
}


class _SampleGraphScreenState extends State<SampleGraphScreen> with API {
    @override

    void initState(){

      super.initState(); 

    }
  
  @override
  Widget build(BuildContext bcontext) {
    final TextEditingController value=TextEditingController();
    print("Sample Graph data 1 ${dataStore.dta}");
    setState(() {

    try{
    int last=int.parse(dataStore.dta.last);
    if(last==0){
      dataStore.notification='No data found ';
    }
    else if(last<95){
      
      dataStore.notification='it is advisable to seek medical attention immediately as your SpO2 level is ${dataStore.dta.last}';
    }
    else {
      dataStore.notification=' Your SpO2 level is $last';
    }
    }
    catch(error){
      print('Nodata');   
    }
  
    });
    return StatefulBuilder(
      builder: (BuildContext context,StateSetter setState){
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
                        initialDate: dataStore.datesp,
                        firstDate: DateTime(2012),
                        lastDate: DateTime(2025)
                        );
                        Future.microtask(() async {
                        await dateCheck(context, newDate);
                        });
                         
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
                        '${dataStore.datesp.day} /${dataStore.datesp.month} /${dataStore.datesp.year}',
                        style: const TextStyle(fontSize: 18,color: Color(0xFF0b5345),fontWeight:FontWeight.bold),
                        ),
                      ),                           
                    ],
                  ),
                ),
        //        GScreen(
        //   setStateCallback: () {
        //     // do
        //   },
        // ),
        Visibility(
               visible:isvisible,
               child: SizedBox(
                 child: Row(
                   children: [
                    horizontaSpace(50),
                     SizedBox(
                      height: 50,
                      width: 200,
                       child: TextFormField(
                             controller:value,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration( 
                                       border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                       ),
                                       //prefixIcon: Icon(Icons.add_circle_outline),
                                       hintText: "Enter SPO2 Here",
                                       labelText: 'SpO2',
                                       hintStyle:const TextStyle(fontSize: 15.0, ),
                                       //errorText: "Error",
                                                 ),
                                      validator: (String? value) {
                                      return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                                      },
                                           ),
                     ),
                     horizontaSpace(20),
                     MeasureButton(buttonText: 'Add', buttonAction: (){
                  int d;
                  try {
                       d = int.parse(value.text);
                      
                      } on FormatException {
        
                        d=0;
        
                        print('Error: Could not parse value as double');
                      }
                //double d=double.parse(value.text);
                addRecord(reading: d, vitalid: 1);
                getReading(date: DateTime.now().toString().substring(0,10), vitalid: 1).then((_) {
                         setState(() { });
                          });
               
                Navigator.pushReplacement(
                bcontext,
                MaterialPageRoute(
                builder: (BuildContext context) => super.widget));
              
                
              },             
              ),
                     
                   ],
                 ),
               ),
             ),
              verticalSpace(20),
              Container(
                  padding:const EdgeInsets.all(20),
                  margin:const EdgeInsets.all(10),
                  height: 100,
                  decoration: BoxDecoration(
                                              color: Colors.lightBlue[50],
                                              border: Border.all(color:Colors.black,width: 2),
                                            ),
                  child:  Center(child: Text(dataStore.notification,style: TextStyle(color: Colors.redAccent[700],fontWeight:FontWeight.bold)
                  )
                  ),
                  ),
                   MeasureButton(buttonText: 'Measure ', buttonAction: (){
                   
                  })
              ],
              ),
             ),
          ),
        );
      }
      );
 }
 
  Future<void> dateCheck(BuildContext context,DateTime?newDate) async{
     if(newDate==null){
                        return;
                        }
      else if(newDate.year == today.year && newDate.month == today.month && newDate.day == today.day){
        isvisible=true;
        //print('Cu isVisible true: $isvisible');
        
        dataStore.datesp=newDate;
        getReading(date: newDate.toString(), vitalid: 1).then((_) {
    // Delay for 2 seconds
    Future.delayed(Duration(seconds: 2)).then((_) {
      // Reload the current page by calling setState
      setState(() {});
    });
  });
        
        // await Future.delayed(Duration(seconds: 3));
        // setState(() {
        //       print('Graph data[0] ${dataStore.dta}');
        //       });
      }
                        else if(newDate.compareTo(DateTime.now())>0)
                        {
                          
                          showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title:const Text("Data Unavailable"),
                            content:const Text("The data you requested is not  available."),
                            actions: [
                              TextButton(
                                child: Text("OK"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        );
                        //ScaffoldMessenger.of(bcontext).showSnackBar (const SnackBar(content: Text('Data Unavailable')));
                        return;
                        }
                        else{
                          isvisible=false;
                          dataStore.datesp=newDate;
                          
                          getReading(date: newDate.toString(), vitalid: 1).then((_) {
      setState(() {
        print('Sample Graph data[0] ${dataStore.dta}');
      });
  });
                          // await Future.delayed(Duration(seconds: 3));
//                           Future.delayed(Duration(seconds: 1), () {
  
// });
                                        }                //print('Graph data[0] ${dataStore.dta}');
    }
  
  }

// class GScreen extends StatefulWidget {
//   final Function setStateCallback;
//   const GScreen({Key? key, required this.setStateCallback}) : super(key: key);

//   //const GScreen({super.key});
  
//   @override
//   State<GScreen> createState() => _GScreenState();
// }

// class _GScreenState extends State<GScreen>
//   with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late TooltipBehavior _tooltipBehavior;
  
//   @override
//   void initState() {
//      _tooltipBehavior =  TooltipBehavior(
//         header: "",
//         enable: true,
//         format: 'point.x : point.y%',
//         canShowMarker: false,

//       );
//     super.initState();
  
//     _controller = AnimationController(vsync: this);
//   }

  
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     print('Gscreen ::${dataStore.dta}');
//     return StatefulBuilder(
//       builder: (BuildContext context,StateSetter setState){
//         return Container(
//               padding:const EdgeInsets.only(left:40,right:30,top:10),
//               //width: 800,
//               height: 300,
//                child: ListView(
//                  physics:const BouncingScrollPhysics(),
//                  scrollDirection: Axis.horizontal,
//                  children:[ 
//                   SizedBox(   
                                                    
//                         child: SfCartesianChart(
//                             // Initialize category axis
//                             title:  ChartTitle(
//                             text: 'Oxygen Saturation',
//                             //backgroundColor: Colors.lightGreen,
//                             //borderColor: Colors.blue,
//                             //borderWidth: 2,
//                             // Aligns the chart title to left
//                             alignment: ChartAlignment.center,
//                             textStyle:const TextStyle(
//                             color: Colors.red,
//                             fontFamily: 'Roboto',
//                             //fontStyle: FontStyle.italic,
//                             fontSize: 20,)
//                              ),
//                              // Enables the tooltip for all the series in chart
//                             tooltipBehavior: _tooltipBehavior,
//                             primaryXAxis: CategoryAxis(),
//                             primaryYAxis: NumericAxis(                 
//                               minimum: 50, 
//                               maximum: 120, 
//                               interval: 5,
//                               // title: AxisTitle(
//                               //   text: 'SPO2%',
//                               //   textStyle:const TextStyle(
//                               //       color: Colors.deepOrange,
//                               //       fontFamily: 'Roboto',
//                               //       fontSize: 16,
//                               //       fontStyle: FontStyle.italic,
//                               //       fontWeight: FontWeight.w300
//                               //   ),
//                               // ),
//                             ),
//                             series: <ChartSeries> [
                            
//                                  getData(widget.setStateCallback)
                                
//                             ]
//                         )
//                     ),
//                  ],
//                ),
//              );
//       });
    
  
    
//   }
// }

// SplineSeries<ChartData, String> getData(Function setStateCallback) {
//   print('getData SplineSeries');
//   //MySharedPreferences myPrefs=MySharedPreferences();
//   //print('Test 1');
//   // List<dynamic>?data=myPrefs.getList('data');
//   // List<dynamic>?time=myPrefs.getList('time');
//   List<ChartData> spData=[];
//   List<double> parsedData = dataStore.dta.map((data) => double.parse(data)).toList();
  
//     for(int i=0;i<dataStore.tme.length;i++){
//       String tme=dataStore.tme[i].toString();
//       spData.add(ChartData(tme.substring(11,16),parsedData[i]));
//     }
//  setStateCallback();
    
// //    for (var time in dataStore.tme) {
// //   spData.add(ChartData(time.toString().substring(11, 16), parsedData.removeAt(0)));
// // } 
  
//   return SplineSeries<ChartData, String>(
    
//     // Create a new LineSeries object
//     dataSource:spData,
//     xValueMapper: (ChartData data, _) => data.x, // Map x values to ChartData.x
//     yValueMapper: (ChartData data, _) => data.y, // Map y values to ChartData.y
//     dataLabelSettings:const DataLabelSettings(isVisible : true)

//   );
  
    
 
// }

// class ChartData {
//         ChartData(this.x, this.y);
//         final String x;
//         final double? y;
//     }
