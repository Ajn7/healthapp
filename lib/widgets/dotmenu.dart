import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../constants/divider.dart';
import '../constants/sharedpref.dart';
import '../core/navigator.dart';



class DotMenu extends StatelessWidget {
  const DotMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
     child: SizedBox(
       width:100,
       child:DropdownButton2(
       isExpanded: true,
       isDense: true,
       customButton: const Icon(
         Icons.more_vert,
         size: 33,
         // color: Colors.red,
       ),
     //customItemsIndexes: const [3],
     //customItemsHeights: 8,
       items: [
         ...MenuItems.firstItems.map(
                   (item) =>
                   DropdownMenuItem<MenuItem>(
                     value: item,
                     child: MenuItems.buildItem(item),
                   ),
         ),
       
          ...MenuItems.secondItems.map(
                   (item) =>
                   DropdownMenuItem<MenuItem>(
                     value: item,
                     child: MenuItems.buildItem(item),
                   ),
         ),
         const DropdownMenuItem<Divider>(enabled: false, child: Divider()),
         ...MenuItems.thirdItems.map(
                   (item) =>
                   DropdownMenuItem<MenuItem>(
                     value: item,
                     child: MenuItems.buildItem(item),
                      
                   ),
         ),
       ],
       onChanged: (value) {
         MenuItems.onChanged(context, value as MenuItem);
       },
       itemHeight: 28,
       //itemWidth: 160,
       itemPadding: const EdgeInsets.only(left: 0, right: 0),
       dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
       dropdownDecoration: BoxDecoration(
         borderRadius: BorderRadius.circular(4),
         color: Colors.white,
       ),
       dropdownElevation: 8,
       offset: const Offset(0, 8),
     ),
     ),
   );
  }
}

class MenuItem {
  final dynamic text;
  final IconData icon;

  const MenuItem({
    required this.text,
    required this.icon,
  });
}

class MenuItems {
  static const List<MenuItem> firstItems = [help]; // [home, share, settings];
  static const List<MenuItem> secondItems = [share];
  static const List<MenuItem> thirdItems = [logout];

  //static const home = MenuItem(text: 'Home', icon: Icons.home);
  
  static const help = MenuItem(text: 'Help', icon: Icons.help_outline);
  static const share = MenuItem(text: 'Share', icon: Icons.share);
  static const logout = MenuItem(text: 'Log Out', icon: Icons.logout);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Icon(
                  item.icon,
                  color: Colors.black,
                  size: 20
          ),
        ),
        horizontaSpace(10),
        Text(
          item.text,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  

  static onChanged(BuildContext context, MenuItem item) async {
    switch (item) {
      //case MenuItems.home:
      //Do something
       // break;
      case MenuItems.help:
          navigatorKey?.currentState?.pushNamed("help");
      //Do something
       break;
      case MenuItems.share:
        //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>  Sample()));
        break;
      case MenuItems.logout:{   
        //SharedPreferences prefs= await SharedPreferences.getInstance();
        // pref.remove(tokens);    
       MySharedPreferences myPrefs = MySharedPreferences();
       await myPrefs.initPrefs();  
       await myPrefs.remove('token');
       await myPrefs.remove('name');
       await myPrefs.remove('email');
       await myPrefs.remove('user_id');
      navigatorKey?.currentState?.pushReplacementNamed("loginscreen");
      }
    }
  }
  
}