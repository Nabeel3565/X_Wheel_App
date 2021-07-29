import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DisplayResult extends StatelessWidget {
  int selected;
  DisplayResult(this.selected);
  final Map<int, String> label = {
    1: "10",
    2: "20",
    3: "30",
    4: "40",
    5: "50",
    6: "60",
    7: "70",
    8: "80",
  };
  var select;
  @override
  Widget build(BuildContext context) {
    select = '${label[selected]}';
    return Text(
      '${label[selected]}',
      style: TextStyle(
          fontSize: 30,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold),
    );
  }
}
