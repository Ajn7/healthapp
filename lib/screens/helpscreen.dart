import 'package:flutter/material.dart';
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
          children: const [
              Text('For futher information please visit'),
              Text('//url'),
              Text('e-mail: contact@intPurple.com'),
              Text('Phone:' ),
              Text('HealthConnect Privacy & Terms and Conditions')
          ],
        ),
      )
      
    );
  }
}
