import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';


class WaveText extends StatelessWidget {
  const WaveText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child:   TextLiquidFill(
      boxHeight: 0,       
      text:' ',
      waveColor: const Color(0xFFB80075),
      //boxBackgroundColor: Colors.transparent,
      textStyle:const TextStyle( 
      fontSize: 40,fontWeight: FontWeight.bold),
      ),
      );
  }
}