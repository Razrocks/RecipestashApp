// Importing necessary packages and files
// Sources/information used:
// - Flutter Documentation: https://docs.flutter.dev/
// - Dart Documentation: https://dart.dev/
// - Firebase Documentation: https://firebase.google.com/docs
// - YouTube Tutorial on Google Login with Firebase Authentication: https://www.youtube.com/watch?v=VCrXSFqdsoA
// - YouTube Tutorial on Flutter Firebase Auth: https://www.youtube.com/watch?v=rWamixHIKmQ

import 'dart:convert';
import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:recipestash/classes/preferences.dart';
import 'package:recipestash/classes/preferences_model.dart';
import 'package:recipestash/utilities/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:recipestash/widget_tree.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

// Global preferences variable
Preferences preferences =
    Preferences(r: 103, g: 202, b: 248, darkMode: 0, notifications: 1);

// Future function to fetch a random cooking tip from a JSON API
Future<String> getRandomTip() async {
  Uri url = Uri.parse(
      "https://my-json-server.typicode.com/MdTanjeemHaider/randomCookingTips/db");
  final response = await http.get(url);

  if (response.statusCode == 200) {
    List<String> tips = List<String>.from(json.decode(response.body)["tips"]);
    return tips[Random().nextInt(tips.length)];
  } else {
    throw Exception("Failed to load tip");
  }
}

// Future function to show daily notifications
Future<void> dailyNotifications() async {
  // Requesting notification permissions
  if (await Permission.notification.status.isDenied) {
    PermissionStatus permissionStatus = await Permission.notification.request();
    if (permissionStatus.isDenied) {
      preferences.notifications = 0;
      await PreferencesModel().update(preferences);
      return;
    }
  }

  // Setting up notifications
  String tipContent = await getRandomTip();
  AndroidInitializationSettings androidInitialize =
      const AndroidInitializationSettings('mipmap/launcher_icon');
  InitializationSettings initializationSettings =
      InitializationSettings(android: androidInitialize);
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails('daily_channel', 'Daily Cooking Tip',
          importance: Importance.max,
          priority: Priority.high,
          styleInformation: BigTextStyleInformation(tipContent));
  NotificationDetails notificationDetails =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  // Showing notifications
  await flutterLocalNotificationsPlugin.periodicallyShow(0, 'Daily Cooking Tip',
      tipContent, RepeatInterval.daily, notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle);

  // (Use this to test if notifications are working)
  // await flutterLocalNotificationsPlugin.show(
  //   0,
  //   'Daily Cooking Tip',
  //   tipContent,
  //   notificationDetails,
  // );
}

// Main function to initialize the app and set preferences
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode
      .immersive); // goes into fullscreen mode for the app and removes status bar + nav buttons
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // If preferences already exist get them, otherwise create them using the default values
  PreferencesModel prefModel = PreferencesModel();
  if (await prefModel.exists() == 0) {
    prefModel.create(preferences);
  } else {
    preferences = await PreferencesModel().get();
  }

  // Daily notifications
  if (preferences.notifications == 1) {
    await dailyNotifications();
  }

  runApp(const MainApp());
}

// StatelessWidget for the main app
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            // Display an error message if Firebase initialization fails
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(child: Text("Error: ${snapshot.error}")),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            // If Firebase initialization is successful, return the main app widget tree
            return const MaterialApp(home: WidgetTree());
          } else {
            // Display a loading indicator while Firebase is initializing
            return const CircularProgressIndicator();
          }
        });
  }
}
