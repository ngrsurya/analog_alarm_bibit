import 'package:flutter/material.dart';

class AlarmText extends StatelessWidget {

  final String hour;
  final String minute;
  final Color textColor;
  final double textSize;

  AlarmText({
    this.hour,
    this.minute,
    this.textColor,
    this.textSize
  });

  buildAll(){
    return Container(
      alignment: Alignment.center,
      child: Text( hour + ':' + minute, style: TextStyle(fontWeight: FontWeight.w500, fontSize: textSize, color: textColor),)
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildAll();
  }
}