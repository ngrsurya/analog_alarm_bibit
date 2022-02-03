import 'dart:io';

final String tableAlarm = 'alarms';

class AlarmFields{

  static final List<String> values = [
    id, hour, minute
  ];

  static final String id = '_id';
  static final String hour = 'hour';
  static const String minute = 'minute';
}

class Alarm{
  
  final int id;
  final String hour;
  final String minute;

  const Alarm({
    this.id,
     this.hour,
     this.minute,
  });

  Alarm copy({
    int id,
    String hour,
    String minute,
  })=> Alarm(
    id: id?? this.id,
    minute: minute?? this.minute,
    hour: hour?? this.hour,
  );

  static Alarm fromJson(Map<String, dynamic> json){
    return new Alarm(
      id: json[AlarmFields.id] as int,
      hour: json[AlarmFields.hour] as String, 
      minute: json[AlarmFields.minute] as String, );
  }
  
  Map<String, Object> toJson() => {
    AlarmFields.id: id,
    AlarmFields.hour: hour,
    AlarmFields.minute: minute,
  };
}