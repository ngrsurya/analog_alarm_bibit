import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationApi{
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifiations = BehaviorSubject<String>();

  static Future _notificationDetails() async{
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        channelDescription:'channel description',
        importance: Importance.max
      ),
      iOS: IOSNotificationDetails()
    );
  }

  static Future init({bool initScheduled = false}) async{
    final iOS =  IOSInitializationSettings();
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final settings = InitializationSettings(android: android, iOS: iOS);

    await _notifications.initialize(
      settings,
      onSelectNotification: (payload) async{
        onNotifiations.add(payload);
      }
    );

    if(initScheduled){
      tz.initializeTimeZones();
      final locationName = await FlutterNativeTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(locationName));
    }
  }

  static Future showNotification({
    int id = 0,
    String title,
    String body,
    String payload
  }) async => _notifications.show(id, title, body, await _notificationDetails(), payload: payload);

  static void showScheduleNotification({
    int id = 0,
    @required String title,
    @required String body,
    @required String payload,
    @required DateTime scheduleDate
  }) async => _notifications.zonedSchedule(
      id, 
      title, 
      body, 
      tz.TZDateTime.from(scheduleDate, tz.local),
      await _notificationDetails(), 
      payload: payload,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:  
        UILocalNotificationDateInterpretation.absoluteTime
    );
}