import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotification = BehaviorSubject<String?>();

  static Future _notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        channelDescription: 'channel description',
        importance: Importance.max,
      ),
      iOS: IOSNotificationDetails(),
    );
  }

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async =>
      _notifications.show(id, title, body, await _notificationDetails(), payload: payload);

  ////////////
  static const android=  AndroidInitializationSettings('@mipmap/ic_launcher');
  static const ios=  IOSInitializationSettings();

  static const settings =  InitializationSettings(android: android,iOS:ios );

  static Future init({bool initScheduled = false}) async {
    await _notifications.initialize(
        settings,
      onSelectNotification: (payload)async{
          onNotification.add(payload);
      }
    );
  }
}
