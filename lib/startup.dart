import 'package:flutter/material.dart';
import 'package:healthapp/login.dart';
import './constants/headline.dart';

class Startup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              headline(),
              Image.asset('assets/images/startup.png'),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(top: 30, bottom: 0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 25),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: const Text("Welcome ",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: IconButton(
                      icon: Icon(
                        Icons.logout,
                      ),
                      iconSize: 50,
                      color: Color(0xFFB80075),
                      splashColor: Colors.grey,
                      onPressed: () {
                       Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()));
                      },
                    ),
                  )),
            ],
          ),
        );
  }
}