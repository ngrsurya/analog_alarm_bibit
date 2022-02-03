import 'dart:math';

import 'package:bibit_test/presentation/templates/color_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:touchable/touchable.dart';


class DashPainter extends CustomPainter{
  final int i;
  final BuildContext context;
  
  Path path = Path();

  DashPainter(
    this.i,
    this.context,
  );
  
  @override
  void paint(Canvas canvas, Size size){
    
    var myCanvas = TouchyCanvas(context, canvas);
    
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    double radius = min(centerX, centerY);
    Offset center = Offset(centerX, centerY);
    double outerRadius = radius - 20;
    double innerRadius = radius - 30;

    DateTime dateTime = DateTime.now();

    Paint dashPaint = Paint()
      ..color = ColorList.softPurple
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    double x1 = centerX - outerRadius * cos(i * pi / 180)* 6;
    double y1 = centerX - outerRadius * sin(i * pi / 180)* 6;
    double x2 = centerX - innerRadius * cos(i * pi / 180)* 3;
    double y2 = centerX - innerRadius * sin(i * pi / 180)* 3;
     
    myCanvas.drawLine(
        Offset(x1, y1), 
        Offset(x2, y2), dashPaint, 
        onTapDown: (tapdetail) {
         print("orange Circle touched");
       },
    ); //Draw Pointer
  }

  @override
  bool hitTest(Offset position) {
    bool hit = path.contains(position);
    print('we');
    return hit;
  
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate){
    return true;
  }
  
}
