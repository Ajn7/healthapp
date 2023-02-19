import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class MyHome extends StatefulWidget {

  String email,password;
   MyHome({Key? key,required this.email,required this.password}) : super(key: key);

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('HealthConnect',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
      ),
      actions: <Widget>[
         DropdownButtonHideUnderline(
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
                 ),
      ],
      backgroundColor: Colors.blue,),
      body: Container(
        padding: EdgeInsets.only(top:7.0),
        //height: 152,
        color:Colors.white,
        child:Column(
          children:<Widget>[
            ListTile(
              title:Text(
                'Previous BP Level',
              style: TextStyle(
                fontSize: 20.0,
              ),
              ),
             subtitle: Text('150',style: TextStyle(
                fontSize: 20.0,
              ),
              ),
             leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  child:CircleAvatar(
                    radius: 20.0,
                    child:Icon(
                      Icons.bloodtype,
                      color:Colors.red,
                      size: 30.0,
                    ),
                    backgroundColor: Colors.white60,
                  )
                ),
              ],
             ),
            ),

           ListTile(
              title:Text(
                'Previous SPO2 Level',
              style: TextStyle(
                fontSize: 20.0,
              ),
              ),
             subtitle: Text('100',style: TextStyle(
                fontSize: 20.0,
              ),
              ),
             leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  child:CircleAvatar(
                    radius: 20.0,
                    child:Icon(
                      Icons.devices,
                      color:Colors.blue,
                      size: 20.0,
                    ),
                    backgroundColor: Colors.white60,
                  )
                ),
              ],
             ),
            ) ,
           Container(
            padding: EdgeInsets.only(top:7.0),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children : [ 
                Row(
                children:[
                  Text("SPO2"),
                  ElevatedButton(onPressed: () { }, child: Text('Measure')),
                ]
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children:[
                  Text('BP'),
                  ElevatedButton(onPressed: () { }, child: Text('Measure')),
                ]
              ),
              ],
            ),
            color:Colors.grey.shade100,
           )
          ],
        ),
      ),
      
      drawer: Drawer(
        child:ListView(
          children: [
            UserAccountsDrawerHeader(accountName: Text(' Albert Louis Jr',
            style:TextStyle(
              fontSize: 21.0,
            ),
            ), 
            accountEmail: Text('louisjr37@gmail.com',),
            otherAccountsPictures: <Widget>[
              IconButton(
              icon: const Icon(Icons.edit),
              color:Colors.white,
              onPressed: () { },
              ),
            ],
          currentAccountPicture:CircleAvatar(
            backgroundImage: AssetImage('assets/images/profile.png'),
          ),
            ),
          ListTile(
            leading: Icon(Icons.person_outline),
            title: Text("Age :"),
            onTap: () { },
          ),
          ListTile(
            leading: Icon(Icons.expand),
            title: Text("Height :"),
            onTap: () { },
          ),
          ListTile(
            leading: Icon(Icons.local_florist),
            title: Text("weight :"),
            onTap: () { },
          ),
          ListTile(
            leading: Icon(Icons.volunteer_activism),
            title: Text("Blood Group :"),
            onTap: () { },
          ),
          ListTile(
            leading: Icon(Icons.emoji_emotions),
            title: Text("Gender :"),
            onTap: () { },
          ),
          ListTile(
            leading: Icon(Icons.insights),
            title: Text("Cholestrol level :"),
            onTap: () { },
          ),
          ListTile(
            leading: Icon(Icons.query_stats),
            title: Text("Sugar Level :"),
            onTap: () { },
          ),
           ListTile(
            leading: Icon(Icons.phone),
            title: Text("Phone :"),
            onTap: () { },
          ),
          Divider(
            height:18,
            color:Colors.black45
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Log Out"),
            onTap: () { },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text("Info"),
            onTap: () { },
          ),
          ],
        )
      ),
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
      case MenuItems.help:
      //Do something
       break;
      case MenuItems.share:
      //Do something
        break;
      case MenuItems.logout:
      //Do something
        break;
    }
  }
}