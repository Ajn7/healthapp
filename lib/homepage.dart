import 'package:flutter/material.dart';
import './constants/headline.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class homepage extends StatefulWidget {
  //constructor 
 
   String email,password;
   homepage({Key? key,required this.email,required this.password}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child:Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                      // ignore: prefer_const_constructors
                      icon: Icon(
                        Icons.menu_sharp,
                      ),
                      iconSize: 40,
                      splashColor: Colors.grey,
                      onPressed: () {
                       
                      },
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                 const Align(
                    alignment: Alignment.topCenter,
                    child:Padding(
                    padding: EdgeInsets.only(top: 10),
                    child:Text('HealthConnect',style: TextStyle(color:Color(0xFFB80075),fontSize: 30,fontWeight: FontWeight.bold)),)
                    ),
                    const SizedBox(
                      width: 10,
                    ),                    
                 DropdownButtonHideUnderline(
                  
          child: SizedBox(
            width:85,
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
              const DropdownMenuItem<Divider>(enabled: false, child: Divider()),
              ...MenuItems.secondItems.map(
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
                 )
              ],
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(top: 30, bottom: 0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 25),
                    ),
                    onPressed: () {
                    },
                    child: SizedBox(height: 20,),
                   ),
                ),
              ),
              const Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(" Home Page "),
                  )),
             Text('Email: ${widget.email}'),//staeful-${widget.name}
            ],
          ),
        )
    );
  }
}


class MenuItem {
  final String text;
  final IconData icon;

  const MenuItem({
    required this.text,
    required this.icon,
  });
}

class MenuItems {
  static const List<MenuItem> firstItems = [share]; // [home, share, settings];
  static const List<MenuItem> secondItems = [logout];

  //static const home = MenuItem(text: 'Home', icon: Icons.home);
  static const share = MenuItem(text: 'Share', icon: Icons.share);
  //static const settings = MenuItem(text: 'Settings', icon: Icons.settings);
  static const logout = MenuItem(text: 'Log Out', icon: Icons.logout);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(
                item.icon,
                color: Colors.black,
                size: 20
        ),
        const SizedBox(
          width: 10,
        ),
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

  static onChanged(BuildContext context, MenuItem item) {
    switch (item) {
      //case MenuItems.home:
      //Do something
       // break;
      //case MenuItems.settings:
      //Do something
       // break;
      case MenuItems.share:
      //Do something
        break;
      case MenuItems.logout:
      //Do something
        break;
    }
  }
}