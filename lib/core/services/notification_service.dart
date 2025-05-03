import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();
    var settings = InitializationSettings(android: android, iOS: ios);

    await _notifications.initialize(settings);

    tz.initializeTimeZones();
  }
  static tz.TZDateTime _nextInstanceOf7AM() {
    final now = tz.TZDateTime.now(tz.local);
    final scheduled = tz.TZDateTime(
      tz.local, now.year, now.month, now.day, 7,);
    return now.isBefore(scheduled) ? scheduled : scheduled.add(
        Duration(days: 1));
  }

  static Future<void> showQuoteNotification(String quote, String author) async {
    final androidDetails = AndroidNotificationDetails(
      'daily_quote_channel',
      'Daily Quote',
      channelDescription: 'Your daily motivational quote',
      importance: Importance.max,
      priority: Priority.high,);

    const iosDetails = DarwinNotificationDetails();
    final details = NotificationDetails(
        android: androidDetails, iOS: iosDetails);

    await _notifications.zonedSchedule(
      0, 'MotivateMe', '"$quote"\n- $author', _nextInstanceOf7AM(), details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,);


  }
}