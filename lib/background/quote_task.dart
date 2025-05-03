import 'package:dio/dio.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:motivate_me/features/quote/data/api/api_service.dart';
import 'package:workmanager/workmanager.dart';

const taskName = "dailyQuoteTask";

void callBackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if(task == taskName){
      final dio = Dio();
      final apiService = ApiService(dio, baseUrl: 'https://zenquotes.io/');

      try {
        final response = await apiService.getRandomQuote();
        final quote = response.first;

        final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
        const androidDetails = AndroidNotificationDetails('quote_channel', "Daily Quote",
        importance: Importance.max,
        priority: Priority.high,);

        const notificationDetails = NotificationDetails(android: androidDetails);

        await flutterLocalNotificationsPlugin.show(0, 'Your daily quote', '${quote.content} - ${quote.author}',
        notificationDetails);
      } catch (e){
        print('Error in background task: $e');
      }
    }
    return Future.value(true);
  });
}
Duration getDelayUntil7AM() {
  final now = DateTime.now();
  final target = DateTime(now.year, now.month, now.day, 7);
  final delay = now.isBefore(target)
      ? target.difference(now)
      : target.add(const Duration(days: 1)).difference(now);
  return delay;
}
