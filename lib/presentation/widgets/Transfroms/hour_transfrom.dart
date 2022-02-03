import 'dart:math';

import 'package:flutter/material.dart';

class ClockWidget extends StatelessWidget {

  final CustomPainter customPainter;

  ClockWidget({
    this.customPainter
  });

  buildAll(){
     return customPainter != null? Transform.rotate(
      angle: pi/2,
      child: Container(
        alignment: Alignment.center,
        child: CustomPaint(
          painter: customPainter
        ),
      ),
    ) : Container();
  }

  @override
  Widget build(BuildContext context) {
    return buildAll();
  }
}