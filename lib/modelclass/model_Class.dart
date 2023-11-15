import 'package:flutter/material.dart';
class Details {
  Details(
      {required this.x,
      required this.open,
      required this.high,
      required this.low,
      required this.close,
      required this.color,
      required this.linevalue});
  final DateTime x;
  double open;
  double high;
  double low;
  double close;
  Color color;
  double linevalue;
}
