import 'package:flutter/material.dart';
import 'package:healthapp/API/model.dart';
import 'package:healthapp/API/apicalls.dart';
import 'package:healthapp/constants/divider.dart';
import 'package:healthapp/screens/bpbtmeasure.dart';
import 'package:healthapp/screens/myhome.dart';
import 'package:healthapp/widgets/measurebutton.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
DataStore dataStore=DataStore();
bool isvisible=true;
DateTime today=DateTime.now();
int len=dataStore.dta.length;
 
class BPScreen extends StatefulWidget {
   const BPScreen({super.key});
  @override
  State<BPScreen> createState() => _BPScreenState();
}


class _BPScreenState extends State<BPScreen> with API {
  

    @override
    void initState(){
      super.initState(); 
      
    }
    @override
  void dispose() {
    isvisible=true;
    dataStore.date=DateTime.now();
    super.dispose();
  }  
  
  @override
  Widget build(BuildContext bcontext) {

    final TextEditingController value=TextEditingController();
    print("Graph data 1 ${dataStore.dta}");
     setState(() {

    try{
    int bpsys=int.parse(dataStore.bpldta.last);
    int bpdia=int.parse(dataStore.bphdta.last);
    //normal range sys 90-120,60-80
    if(bpsys==0 && bpdia==0){
      dataStore.notification='No data found ';
    }
    else if(bpsys>=140 || bpdia>=90){ //sys >=140, dia>=90
      
      dataStore.notification='it is advisable to seek medical attention immediately as your Blood Pressure level is High $bpsys/$bpdia';
    }
    else if(bpsys<90 || bpdia<60){ //sys less90, lessthan60
      
      dataStore.notification='it is advisable to seek medical attention immediately as your Blood Pressure level is Low $bpsys/$bpdia';
    }
    else {
      dataStore.notification=' Your Blood Pressure level is $bpsys/$bpdia';
    }
    }
    catch(error){
      print('Nodata');
       
    }
  
    });
     return WillPopScope(
       onWillPop: () async{
        Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const MyHome()),
         ModalRoute.withName('/oldScreen'),
        );
        return true;
      },
      child: StatefulBuilder(
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
                 GScreen(
            setStateCallback: () {
              // do
            },
          ),
          Visibility(
                 visible:isvisible,
                 child: SizedBox(
                   child: Column(
                     children: [
                       MeasureButton(buttonText: 'Measure ', buttonAction: (){
                       Navigator.pushReplacement(
                       bcontext,
                       MaterialPageRoute(
                       builder: (BuildContext context) =>const ConnectedBpBluetoothDevicesPage()));
                     
                    }),
                    verticalSpace(20),
                    const Text('Or Add Data Manually'),
                    verticalSpace(10),
                       Row(
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
                                             hintText: "Enter BP Here",
                                             labelText: 'BP',
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
                        String d;
                        try {
                              d = (value.text).toString();
                            
                            } on FormatException {
          
                              d=' ';
          
                              print('Error: Could not parse value as double');
                            }
                  //double d=double.parse(value.text);
                  addBpRecord(reading: d, vitalid: 2);
                  navigateToNextScreen(context);
       
                  // Navigator.pushReplacement(
                  // bcontext,
                  // MaterialPageRoute(
                  // builder: (BuildContext context) => super.widget));
                
                  
                },             
                ),
                
                           
                         ],
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
                     
                ],
                ),
               ),
            ),
          );
        }
        ),
    ); 
     // WillPopScope(
    //   onWillPop: () async{
    //     Navigator.pushAndRemoveUntil(
    //     context,
    //     MaterialPageRoute(builder: (context) => const MyHome()),
    //      ModalRoute.withName('/oldScreen'),
    //     );
    //     return true;
    //   },
    //   child: StatefulBuilder(
    //     builder: (BuildContext context,StateSetter setState){
    //       return Scaffold(
    //         backgroundColor: Colors.white,
    //         appBar: AppBar(title: const Text('HealthConnect',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold))),
    //         body: SingleChildScrollView(
    //           child: SafeArea(
    //             child:Column(
    //             children: [
    //               InkWell(
    //                 onTap:()async{
    //                       DateTime?newDate=await showDatePicker(context: context, 
    //                       initialDate:dataStore.date,
    //                       firstDate: DateTime(2012),
    //                       lastDate: DateTime(2025)
    //                       );
    //                       Future.microtask(() async {
    //                       await dateCheck(context, newDate);
    //                       });
                           
    //                       },
    //                 child: Row(
    //                   children: [
    //                     const Padding(
    //                       padding:EdgeInsets.only(left:20,top: 20,right: 8),
    //                       child: Icon(
    //                       size: 40,
    //                       color: Colors.blue,
    //                       Icons.edit_calendar_outlined
    //                       ),
    //                     ),
    //                     Padding(
    //                       padding: const EdgeInsets.only(top:20.0,right: 10),
    //                       child: Text(
    //                       '${dataStore.date.day} /${dataStore.date.month} /${dataStore.date.year}',
    //                       style: const TextStyle(fontSize: 18,color: Color(0xFF0b5345),fontWeight:FontWeight.bold),
    //                       ),
    //                     ),                           
    //                   ],
    //                 ),
    //               ),
    //              GScreen(
    //         setStateCallback: () {
    //           // do
    //         },
    //               )  ,
    //               verticalSpace(20),
    //              Visibility(
    //                visible:isvisible,
    //                child: SizedBox(
    //                  child: Row(
    //                    children: [
    //                     horizontaSpace(50),
    //                      SizedBox(
    //                       height: 50,
    //                       width: 200,
    //                        child: TextFormField(
    //                              controller:value,
    //                             keyboardType: TextInputType.emailAddress,
    //                             decoration: InputDecoration( 
    //                                        border: OutlineInputBorder(
    //                                         borderRadius: BorderRadius.circular(10.0),
    //                                        ),
    //                                        //prefixIcon: Icon(Icons.add_circle_outline),
    //                                        hintText: "Enter Blood Pressure Here",
    //                                        labelText: 'BP',
    //                                        hintStyle:const TextStyle(fontSize: 15.0, ),
    //                                        //errorText: "Error",
    //                                                  ),
    //                                       validator: (String? value) {
    //                                       return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
    //                                       },
    //                                            ),
    //                      ),
    //                      horizontaSpace(20),
    //                      MeasureButton(buttonText: 'Add', buttonAction: (){
    //                   String d;
    //                   try {
    //                        d = (value.text).toString();
                          
    //                       } on FormatException {
                     
    //                         d=' ';
                     
    //                         print('Error: Could not parse value as double');
    //                       }
    //                                //double d=double.parse(value.text);
    //                                addBpRecord(reading: d, vitalid: 2);
    //                                navigateToNextScreen(context);
                                                          
    //                              },             
    //                              ),
    //                    ],
    //                  ),
    //                ),
    //              ),
    //             verticalSpace(50),
    //             Container(
    //                 padding:const EdgeInsets.all(20),
    //                 margin:const EdgeInsets.all(10),
    //                 height: 100,
    //                 decoration: BoxDecoration(
    //                                             color: Colors.lightBlue[50],
    //                                             border: Border.all(color:Colors.black,width: 2),
    //                                           ),
    //                 child:  Center(child: Text(dataStore.notification,style: TextStyle(color: Colors.redAccent[700],fontWeight:FontWeight.bold))),
    //                 ),
    //                 MeasureButton(buttonText: 'Measure ', buttonAction: (){
    //                   Navigator.pushReplacement(
    //                    bcontext,
    //                    MaterialPageRoute(
    //                    builder: (BuildContext context) =>const ConnectedBpBluetoothDevicesPage()));
    //                   //Navigator.push(context, MaterialPageRoute(builder:(context)=>MyWidget())); refresh
    //                 }) 
                    
    //             ],
    //             ),
    //            ),
    //         ),
    //       );
    //     }
    //     ),
    // );
 }
 
  Future<void> dateCheck(BuildContext context,DateTime?newDate) async{
     if(newDate==null){
                        return;
                        }
      else if(newDate.year == today.year && newDate.month == today.month && newDate.day == today.day){
        isvisible=true;
        //print('Cu isVisible true: $isvisible');
        //print(newDate.compareTo(DateTime.now())==0);
        
        dataStore.date=newDate;
                         
                          getReadingBp(date: newDate.toString(), vitalid: 2).then((_) {
      setState(() {
        print('Sample Graph data[0] ${dataStore.dta}');
      });
  });
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
                          print('isvisible is :$isvisible');
                          dataStore.date=newDate;
                          getReadingBp(date: newDate.toString(), vitalid: 2).then((_) {
      setState(() {
        print('Sample Graph data[0] ${dataStore.dta}');
      });
  });
//                           Future.delayed(Duration(seconds: 1), () {
  
// });
                          //print('Graph data[0] ${dataStore.dta}');
    }
  }
  
    void navigateToNextScreen(context) async {
   await Future.delayed(const Duration(seconds: 1),(){
      
    });
 Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (BuildContext context) => super.widget,
    ),
  );
  
}
 
  }

class GScreen extends StatefulWidget {
  final Function setStateCallback;
  const GScreen({Key? key, required this.setStateCallback}) : super(key: key);

  //const GScreen({super.key});
  
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
    print('Gscreen ::${dataStore.dta}');
    return StatefulBuilder(
      builder: (BuildContext context,StateSetter setState){
        return Container(
              padding:const EdgeInsets.only(left:40,right:30,top:10),
              //width: 1500,
              height: 300,
               child: ListView(
                 physics:const BouncingScrollPhysics(),
                 scrollDirection: Axis.horizontal,
                 children:[ 
                  SizedBox(   
                                                    
                        child: SfCartesianChart(
                            // Initialize category axis
                            title:  ChartTitle(
                            text: 'Blood Pressure',
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
                              maximum: 160, 
                              interval: 5,
                             
                            ),
                            legend:Legend(
                              isVisible: true, 
                              position: LegendPosition.bottom,
                              textStyle:const TextStyle(fontSize:15),
                               backgroundColor: Colors.yellow.shade200,
                            ),
                            series: <ChartSeries> [
                                 
                            
                                 getData(widget.setStateCallback),
                                 getDatatwo(widget.setStateCallback)
                                
                            ],
        
                        )
                    ),
                 ],
               ),
             );
      });
    
  
    
  }
}

SplineSeries<ChartData, String> getData(Function setStateCallback) {
  
  print('bpgetData SplineSeries');
  List<ChartData> spData=[];
  List<double> parsedData = dataStore.bpldta.map((data) => double.parse(data)).toList();
   print(' BP dataLength: ${dataStore.bptme.length}');
    for(int i=0;i<(dataStore.bptme.length);i++){
      //print('for loop:$i');
      String time=dataStore.bptme[i].toString();
      spData.add(ChartData(time.substring(11,16),parsedData[i]));
    }
 setStateCallback();
  
  return SplineSeries<ChartData, String>(
    name: 'Systolic',
    // Create a new LineSeries object
    dataSource:spData,
    xValueMapper: (ChartData data, _) => data.x, // Map x values to ChartData.x
    yValueMapper: (ChartData data, _) => data.y, // Map y values to ChartData.y
    dataLabelSettings:const DataLabelSettings(isVisible : true)

  );
  
    
 
}
SplineSeries<ChartData, String> getDatatwo(Function setStateCallback) {
  print('getDatatwo SplineSeries');
  List<ChartData> spData=[];
  List<double> parsedData = dataStore.bphdta.map((data) => double.parse(data)).toList();
  
    for(int i=0;i<dataStore.bptme.length;i++){
      String time=dataStore.bptme[i].toString();
      spData.add(ChartData(time.substring(11,16),parsedData[i]));
    }
 setStateCallback();
  
  return SplineSeries<ChartData, String>(
    name: 'Diastolic',
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



