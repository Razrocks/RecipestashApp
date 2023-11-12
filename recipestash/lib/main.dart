import 'dart:convert';
import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:recipestash/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:recipestash/widget_tree.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

Future<String> getRandomTip() async {
  Uri url = Uri.parse("https://my-json-server.typicode.com/MdTanjeemHaider/randomCookingTips/db");
  final response = await http.get(url);

  if (response.statusCode == 200){
    List<String> tips = List<String>.from(json.decode(response.body)["tips"]);
    return tips[Random().nextInt(tips.length)];
  }
  else {
    throw Exception("Failed to load tip");
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive); // goes into fullscreen mode for the app and removes status bar + nav buttons
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Daily notifications
  AndroidInitializationSettings androidInitialize = const AndroidInitializationSettings('mipmap/launcher_icon');
  InitializationSettings initializationSettings = InitializationSettings(android: androidInitialize);
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  AndroidNotificationDetails androidPlatformChannelSpecifics = const AndroidNotificationDetails(
    'daily_channel',
    'Daily Cooking Tip',
    importance: Importance.max,
    priority: Priority.high,);
  NotificationDetails notificationDetails = NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.periodicallyShow(
    0,
    'Daily Cooking Tip',
    await getRandomTip(),
    RepeatInterval.daily,
    notificationDetails,
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text("Error: ${snapshot.error}")
              ),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            darkTheme: ThemeData.dark(),
            home: WidgetTree()
          );
        }
        else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}