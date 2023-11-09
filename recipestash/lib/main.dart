import 'package:firebase_core/firebase_core.dart';
import 'package:recipestash/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:recipestash/widget_tree.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
          return const MaterialApp(
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