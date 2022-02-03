import 'dart:async';
import 'dart:math';

import 'package:bibit_test/business%20logic/Controller/notification_api.dart';
import 'package:bibit_test/business%20logic/blocs/clock/bloc/clock_bloc.dart';
import 'package:bibit_test/presentation/templates/color_list.dart';
import 'package:bibit_test/presentation/widgets/Buttons/button_widget.dart';
import 'package:bibit_test/presentation/widgets/Texts/alarm_text.dart';
import 'package:bibit_test/presentation/widgets/Transfroms/hour_transfrom.dart';
import 'package:bibit_test/presentation/widgets/clock_pointers/clock_pointer.dart';
import 'package:bibit_test/presentation/widgets/clock_pointers/dash_pointer.dart';
import 'package:flutter/material.dart';

import 'package:timer_builder/timer_builder.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:touchable/touchable.dart';


class ClockPage extends StatefulWidget {

  @override
  _ClockPageState createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {

  //Data
  Offset defaultOffset = Offset(0,0);

  //Widgets
  List<Widget> dashPoints = [];

  @override
  void initState() {
    super.initState(); 
    timer();
    setDashPointer();

    NotificationApi.init(initScheduled: true);
    listenNotifications();
  } 

  String getSystemTime() {
    var now = new DateTime.now();
    return new DateFormat("H:mm").format(now);
  }

  timer(){
    BlocProvider.of<ClockBloc>(context).getAllAlarmDatabase(); //Set the offset 
    Timer.periodic(Duration(seconds: 1), (timer){setState(() {});});
  }

  setDashPointer(){
    print('reset');
    var point;
    int hour = 6;
    for(int i = 0; i < 360;  i += 30){
      point = buildDashPointer(i);

      hour += 6;
      dashPoints.add(point);
    }
  }

  void listenNotifications() => NotificationApi.onNotifiations.stream.listen((event) {BlocProvider.of<ClockBloc>(context).deleteAlarm(event);});
  
  //=====================================================================================================================================  
  //SINGLE BUILDER
  buildDashPointer(int i){
    return Container(
      child: CustomPaint(
        painter: DashPainter(i, context),
      ),
    ); 
  }


  buildBackCircle(){
    var size = MediaQuery.of(this.context).size;
    return Container(
      height: size.height * .6,
      width: size.width * .7,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: ColorList.primaryColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: ColorList.softGrey,
            blurRadius: 30,
            offset: Offset(18, 5)
          ),
          BoxShadow(
            color: ColorList.softGrey,
            blurRadius: 30,
            offset: Offset(18, -10)
          )
        ]
      ),
    );
  }

  buildFrontCircle(){
    var size = MediaQuery.of(this.context).size;
    return Container(
      height: size.height * .2,
      width: size.width * .25,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: CircularButton(func:()=> BlocProvider.of<ClockBloc>(context).setAlarm(this.context), title: 'ALARM', width: 80, height: 70, backColor: Colors.white, titleColor: ColorList.primaryColor),
    );
  }

  buildClockPainter(){
    return Transform.rotate(
      angle: pi/2,
      child: Container(
        alignment: Alignment.center,
        child: CustomPaint(
          painter: ClockPainter()
        ),
      ),
    );
  }

  buildDigitalClock(){
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Hour:' ,style: TextStyle(fontSize: 20, color: ColorList.primaryColor,)),
          TimerBuilder.periodic(Duration(seconds: 1), builder: (context) {
            return Text(
              "${getSystemTime()}",
              style: TextStyle(
                fontSize: 30,
                color: ColorList.primaryColor,
                fontWeight: FontWeight.w700),
            );
          }),
        ],
      ),
    );
  }

  buildAllDashPointer(){
    return Container(
      alignment: Alignment.center,
      child: Stack(
        children: dashPoints.length> 0? dashPoints : [SizedBox()],
      ),
    );
  }

  buildListAlarm(){
    var size  = MediaQuery.of(context).size;
    return Container(
      height: size.height * .3,
      alignment: Alignment.center,
      child: BlocBuilder<ClockBloc, ClockState>(
        builder: (context, state){
          return ListView(
            children: state.alarmCard != null? state.alarmCard : [SizedBox()],
          );
        }
      )
    );
  }  

  //BUILDER
  //=======================================================================================================================================

  buildAll(){
    var size = MediaQuery.of(this.context).size;
    return Container(
      color: ColorList.accentColor,
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 15, right:15, top: size.height * .1 ),
      height: size.height,
      width: size.width,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildDigitalClock(),
            //Analog Clock
            Container(
              height: size.height * .4,
              alignment: Alignment.center,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  buildBackCircle(), //Backdrop clock
                 
                  //Painter
                  buildClockPainter(),
                  buildAllDashPointer(),
      
                  buildFrontCircle() //Upfront clock
                ],
              ),
            ),
            //Alarm Setter
            Container(
              alignment: Alignment.centerLeft,
              child: Text('Alarm:' ,style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.grey,))),
            SizedBox(height: 10),
            buildListAlarm()
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildAll(),
    );
  }
}
