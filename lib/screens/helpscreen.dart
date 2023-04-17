import 'package:flutter/material.dart';
import 'package:healthapp/constants/divider.dart';
import 'package:url_launcher/url_launcher.dart';

class helpscreen extends StatefulWidget {
  const helpscreen({super.key});

  @override
  State<helpscreen> createState() => _helpscreenState();
}

class _helpscreenState extends State<helpscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Text('For futher information please visit'),
            TextButton(
              onPressed: launchURL,
              child: Text('https://intpurple.com/'),
            ),
              Text('Email:contact@intpurple.com'),
              Text('Phone: +91 786754676543' ),
              verticalSpace(10),
              TextButton(
              onPressed: launchTerms,
              child: Text('Privacy & Terms and Conditions'),
            ),
          ],
        ),
      )
      
    );
  }

launchURL() async {
  const url = 'https://intpurple.com/about-us/';
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    throw 'Could not launch $uri';
  }
}
launchTerms() async {
  const url = 'https://intpurple.com/about-us/';
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    throw 'Could not launch $uri';
  }
}


}



