import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  
  final Function func;
  final String title;
  final double width;
  final double height;
  final Color backColor;
  final Color titleColor;

  CircularButton({
    this.func, 
    this.title, 
    this.width, 
    this.height, 
    this.backColor, 
    this.titleColor});

  buildAll(){
    return Container(
      height: height,
      width: width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: backColor,
      ),
      child: FittedBox(
        fit: BoxFit.cover,
        child: FlatButton(
          onPressed: func,
          child: Text(title, style: TextStyle(color: titleColor, fontWeight: FontWeight.w400),),
        ),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return buildAll();
  }
}