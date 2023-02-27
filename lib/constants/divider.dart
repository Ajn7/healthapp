import 'package:flutter/material.dart';

Widget verticalSpace(double value) {
  if (value < 0) {
    value = 0;
  }
  return SizedBox(height: value);
}

Widget horizontaSpace(double value) {
  if (value < 0) {
    value = 0;
  }
  return SizedBox(width: value);
}