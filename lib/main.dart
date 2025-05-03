import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motivate_me/app.dart';
import 'package:motivate_me/core/services/notification_service.dart';
import 'package:workmanager/workmanager.dart';
import 'package:motivate_me/background/quote_task.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  const initializationSettings = InitializationSettings(
    android: AndroidInitializationSettings('@mipmap/ic_launcher'),
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  Workmanager().initialize(callBackDispatcher, isInDebugMode: false);
  Workmanager().registerPeriodicTask("dailyQuoteTask", taskName,
  frequency: const Duration(hours: 24),
  initialDelay: getDelayUntil7AM());
  runApp(const ProviderScope(child: MyApp()));
}

