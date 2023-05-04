import 'package:flutter/material.dart';

class VitalListTile extends StatelessWidget {
  final String msg;
  final dynamic value;
   final IconData iconData;
  const VitalListTile({
    required this.msg,
    this.value,
    required this.iconData,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
      msg, //Previous SPO2 Level
      style: const TextStyle(
        fontSize: 20.0,
      ),
      ),
     subtitle:Text('$value',style: const TextStyle(
        fontSize: 20.0,
      ),
      ),
     leading: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
         SizedBox(
          height: (MediaQuery.of(context).size.height)*0.2,
          child:CircleAvatar(
            radius: 20.0,
            backgroundColor: Colors.white60,
            child:Icon(
              iconData,
              color:Colors.red,
              size: 30.0,
            ),
          )
        ),
      ],
     ),
    );
  }
}