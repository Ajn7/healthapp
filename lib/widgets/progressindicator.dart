import 'package:flutter/material.dart';

class Progressindicator extends StatelessWidget {
  const Progressindicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(
          Colors.purple),
          );
  }
}