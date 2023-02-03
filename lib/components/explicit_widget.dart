import 'package:flutter/material.dart';

class ExplicitWidget extends StatelessWidget {
  ExplicitWidget({
    Key? key,
  }) : super(key: key);
  final textStyle =
      TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold);
  final boxDecoration =
      BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(2));
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: boxDecoration,
        margin: const EdgeInsets.only(right: 4),
        height: 12,
        width: 12,
        child: Center(
          child: Text('E', style: textStyle),
        ));
  }
}
