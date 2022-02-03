import 'package:bibit_test/presentation/templates/color_list.dart';
import 'package:flutter/material.dart';

class AlarmCard extends StatelessWidget {

  final String hour;
  final String minute;

  AlarmCard({
    this.hour,
    this.minute
  });

  buildAll(){
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: ColorList.accentColor,
        border: Border.all(color: Colors.grey, width: 2)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(hour +':' + minute, style: TextStyle(color: ColorList.primaryColor, fontWeight: FontWeight.w600, fontSize: 13),),
          Icon(Icons.alarm, color: Colors.grey,)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildAll();
  }
}