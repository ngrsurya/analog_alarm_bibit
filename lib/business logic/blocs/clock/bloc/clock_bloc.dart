import 'dart:async';
import 'dart:math';

import 'package:bibit_test/Model/alarm.dart';
import 'package:bibit_test/business%20logic/Controller/notification_api.dart';
import 'package:bibit_test/db/alarm_database.dart';
import 'package:bibit_test/presentation/widgets/Cards/alarm_card.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'clock_event.dart';
part 'clock_state.dart';

class ClockBloc extends Bloc<ClockEvent, ClockState> {
  ClockBloc() : super(ClockState(
      isActive: false, 
      isAlarm: false, 
      centerOffset: Offset(0,0), 
      secEndOffset: Offset(0,0), 
      minEndOffset: Offset(0,0), 
      hourEndOffset: Offset(0,0)));

  
  timer(double _screenWidth, double _screenHeight){ 
    Timer.periodic(Duration(seconds: 1), (timer){
      setAllOffset(_screenWidth, _screenHeight);
    });
  }
  
  testing(){
    print('hahahha');
  }

  void setAllOffset(double _screenWidth, double _screenHeight){

    double centerX = _screenWidth / 2;
    double centerY = _screenHeight / 2;
    double radius = min(centerX, centerY);
    Offset center = Offset(0, 0);
    double outerRadius = radius - 20;

    DateTime dateTime = DateTime.now();

    //Center Offset
    var _centerOffset = center;

    //Second Offset
    var _secEndOffset = -Offset(
      centerX - outerRadius * 6 * cos(dateTime.second * 6 * pi / 180),
      centerY - outerRadius * 6 *  sin(dateTime.second * 6 * pi / 180) 
    );

    //Minute Offset
    var _minEndOffset = -Offset(
     centerX - outerRadius * .2 * cos(dateTime.minute * 6 * pi / 180),
     centerX - outerRadius * .2 * sin(dateTime.minute * 6 * pi / 180),
    );

    //Hour Offset
    var _hourEndOffset = -Offset(
      centerX - outerRadius * .1 * cos(dateTime.minute * 5 * pi / 180),
      centerY - outerRadius * .1 * sin(dateTime.minute * 6 * pi / 180),
    );

    print(_secEndOffset);

    emit(ClockState(    
      isActive: false, 
      isAlarm: false, 
      centerOffset: state.centerOffset = _centerOffset, 
      secEndOffset: state.secEndOffset = _secEndOffset, 
      minEndOffset: state.minEndOffset =  _minEndOffset, 
      hourEndOffset: state.hourEndOffset = _hourEndOffset));
  }

  setAlarm(var _context) async{
    var initialTime = TimeOfDay.now();
    TimeOfDay time = await showTimePicker(context: _context, initialTime: initialTime,
      builder: (BuildContext context, Widget child){
        return Theme(data: ThemeData(), child: child);
      }
    );

    if(time != null)
    {
      initialTime = time;
      int hour = initialTime.hour;
      int minute = initialTime.minute;
      String currentDay = DateFormat('yyyy-MM-dd').format(DateTime.now());
      String timeSet = currentDay + ' ' + hour.toString() + ':' + minute.toString();
      DateTime tempDate = new DateFormat('yyyy-MM-dd HH:mm').parse(timeSet);
      
      Alarm alarm = await saveAlarmDatabase(hour.toString(), minute.toString());
      print(alarm.id);
      NotificationApi.showScheduleNotification(scheduleDate: tempDate, title: 'Alarm', body: timeSet, payload: alarm.id.toString());
    }
  }

  Future<Alarm> saveAlarmDatabase(String hour, String minute)async{
    print('save alarm');
    var item = new Alarm(minute: minute, hour: hour);
    var valToReturn = await AlarmDatabase.instance.create(item);

    await getAllAlarmDatabase();
    return valToReturn;
  }

  getAllAlarmDatabase() async{
    print('get alarm list');
    List<Alarm> item = await AlarmDatabase.instance.getAllAlarms();
    List<Widget> alarmCard = [];
    for(var data in item)
    {
      var alm = AlarmCard(hour: data.hour, minute: data.minute);
      alarmCard.add(alm);
    }

    emit(ClockState(    
      isActive: false, 
      isAlarm: false, 
      alarmCard: state.alarmCard = alarmCard,
     ));
    
  }

  deleteAlarm(String payload) async{
    print('delete jam');
    int _id = int.parse(payload); 
    await AlarmDatabase.instance.delete(_id);
    await getAllAlarmDatabase(); //Reset get alarm list
  }
}
