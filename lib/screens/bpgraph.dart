import 'package:flutter/material.dart';
import 'package:healthapp/API/model.dart';
import 'package:healthapp/API/apicalls.dart';
import 'package:healthapp/widgets/measurebutton.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
DataStore dataStore=DataStore();

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
  Widget build(BuildContext bcontext) {
    final TextEditingController value=TextEditingController();
    print("Graph data 1 ${dataStore.dta}");
     setState(() {

    try{
    int last=int.parse(dataStore.bphdta.last);
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
                        initialDate:dataStore.date,
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
                        '${dataStore.date.day} /${dataStore.date.month} /${dataStore.date.year}',
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
        )  ,
               SizedBox(
                height: 50,
                width: 200,
                 child: TextFormField(
                       controller:value,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration( 
                                 border: OutlineInputBorder(),
                                 prefixIcon: Icon(Icons.add_circle_outline),
                                 hintText: "Enter SPO2 Here",
                                 hintStyle: TextStyle(fontSize: 20.0, ),
                                 //labelText: "Last Name",
                                 //labelStyle: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                                           ),
                      
                                     ),
               ),
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
                getReadingBp(date: DateTime.now().toString().substring(0,10), vitalid: 2);
               
                Navigator.pushReplacement(
                bcontext,
                MaterialPageRoute(
                builder: (BuildContext context) => super.widget));
              
                
              },             
              ),
              Container(
                  padding:const EdgeInsets.all(20),
                  margin:const EdgeInsets.all(10),
                  height: 100,
                  decoration: BoxDecoration(
                                              color: Colors.lightBlue[50],
                                              border: Border.all(color:Colors.black,width: 2),
                                            ),
                  child:  Center(child: Text(dataStore.notification,style: TextStyle(color: Colors.redAccent[700],fontWeight:FontWeight.bold))),
                  ),
                  
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
                          dataStore.date=newDate;
                          getReadingBp(date: newDate.toString(), vitalid: 2);
                          setState(() {
                          print('Graph data[0] ${dataStore.dta}');
                          });
//                           Future.delayed(Duration(seconds: 1), () {
  
// });
                          //print('Graph data[0] ${dataStore.dta}');
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
                              maximum: 120, 
                              interval: 5,
                             
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
  List<double> parsedData = dataStore.bphdta.map((data) => double.parse(data)).toList();
   print(' 22 ${dataStore.bptme.length}');
    for(int i=0;i<(dataStore.bptme.length);i++){
      //print('for loop:$i');
      String time=dataStore.bptme[i].toString();
      spData.add(ChartData(time.substring(11,16),parsedData[i]));
    }
 setStateCallback();
  
  return SplineSeries<ChartData, String>(
    
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
  List<double> parsedData = dataStore.bpldta.map((data) => double.parse(data)).toList();
  
    for(int i=0;i<dataStore.bptme.length;i++){
      String time=dataStore.bptme[i].toString();
      spData.add(ChartData(time.substring(11,16),parsedData[i]));
    }
 setStateCallback();
  
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



