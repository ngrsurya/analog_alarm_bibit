
import 'dart:math';

import 'package:flutter/material.dart';

class ClockPainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size){
    
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    double radius = min(centerX, centerY);
    Offset center = Offset(centerX, centerY);
    double outerRadius = radius - 20;
    double innerRadius = radius - 30;

    DateTime dateTime = DateTime.now();

    Paint secLinePaint = Paint()
    ..color = Colors.white
    ..strokeWidth = 4
    ..strokeCap = StrokeCap.round;

    Paint minLinePaint = Paint()
    ..color = Colors.white
    ..strokeWidth = 3
    ..strokeCap = StrokeCap.round;

    Paint hourLinePaint = Paint()
    ..color = Colors.white
    ..strokeWidth = 6
    ..strokeCap = StrokeCap.round;

    //Second
    Offset secEndOffset = Offset(
      centerX - outerRadius * 6 * cos(dateTime.second * 6 * pi / 180),
      centerY - outerRadius * 6 * sin(dateTime.second * 6 * pi / 180) 
    );

    //Minute
    Offset minEndOffset = -Offset(
      centerX - outerRadius * 6 * cos(dateTime.minute * 6 * pi / 180),
      centerY - outerRadius * 6 * sin(dateTime.minute * 6 * pi / 180),
    );

    //Hour
    Offset hourEndOffset = Offset(
      centerX - outerRadius * 4 * -cos(dateTime.hour * 6 * -pi / 180),
      centerY - outerRadius * 4 * sin(dateTime.hour * 6 * -pi / 180)
    );

  

    canvas.drawLine(center, secEndOffset, secLinePaint); //Draw Second
    canvas.drawLine(center, minEndOffset, minLinePaint); //Draw Minute
    canvas.drawLine(center, hourEndOffset, hourLinePaint); //Draw Hour
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate){
    return true;
  }
}

