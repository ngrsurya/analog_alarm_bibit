part of 'clock_bloc.dart';

class ClockState {
  List<Widget> alarmCard;
  bool isAlarm;
  bool isActive;
  Offset centerOffset;
  Offset secEndOffset;
  Offset minEndOffset;
  Offset hourEndOffset;
  double centerX;
  double centerY;
  double outerRadius;
  double innerRadius;
  bool isMorning;


  ClockState({
    this.isAlarm = false,
    this.isActive = false,
    this.alarmCard,
    this.centerOffset,
    this.secEndOffset,
    this.minEndOffset,
    this.hourEndOffset,
    this.centerX,
    this.centerY,
    this.outerRadius,
    this.innerRadius,
    this.isMorning
  });
}
