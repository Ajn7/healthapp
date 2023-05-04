import 'package:flutter/material.dart';


import 'package:healthapp/core/navigator.dart';
import 'package:healthapp/constants/sharedpref.dart';
import 'package:healthapp/API/model.dart';
import 'package:healthapp/screens/editinfo.dart';
DataStore dataStore = DataStore();

class PersonalInfoList extends StatelessWidget {
  const PersonalInfoList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        UserAccountsDrawerHeader(
        accountName: Text(dataStore.name.toUpperCase(),
        style:const TextStyle(
          fontSize: 21.0,
        ),
        ), 
        accountEmail:Text(dataStore.email),
        otherAccountsPictures: <Widget>[
          IconButton(
          icon: const Icon(Icons.edit),
          color:Colors.white,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const EditInfo()));
           },
          ),
        ],
                currentAccountPicture:const CircleAvatar(
        backgroundImage: AssetImage('assets/images/profile.png'),
                ),
        ),
       ListTile(
        leading:const Icon(Icons.person_outline),
        title: Text("Age :${dataStore.age}"),
        //onTap: () { },
      ),
       ListTile(
        leading:const Icon(Icons.expand),
        title: Text("Height :${dataStore.height}"),
        //onTap: () { },
      ),
       ListTile(
        leading:const Icon(Icons.local_florist),
        title: Text("weight :${dataStore.weight}"),
        //onTap: () { },
      ),
       ListTile(
        leading:const Icon(Icons.volunteer_activism),
        title: Text("Blood Group :${dataStore.bloodgroup}"),
        //onTap: () { },
      ),
        ListTile(
        leading:const Icon(Icons.phone),
        title: Text("Phone :${dataStore.phone}"),
       // onTap: () { },
      ),
      const Divider(
        height:10,
        color:Colors.black45
      ),
      ListTile(
        leading: const Icon(Icons.password),
        title: const Text("Change Password"),
        onTap: () { },
      ),
      ListTile(
        leading: const Icon(Icons.exit_to_app),
        title: const Text("Log Out"),
        onTap: () async {
          //SharedPreferences pref = await SharedPreferences.getInstance();
          //pref.remove(tokens);
          MySharedPreferences myPrefs = MySharedPreferences();
          await myPrefs.initPrefs();  
          await myPrefs.remove('token');
          await myPrefs.remove('name');
          await myPrefs.remove('email');
          await myPrefs.remove('user_id');
          navigatorKey?.currentState?.pushReplacementNamed("loginscreen");
         },
      ),
      ],
    );
  }
}