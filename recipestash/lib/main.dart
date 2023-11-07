import 'package:firebase_core/firebase_core.dart';
import 'package:recipestash/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:recipestash/pages/home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print('connection error');
        }
        if (snapshot.connectionState == ConnectionState.done) {
          print('successfully connected to firebase');
          return const MaterialApp(
            home: Home()
          );
        }
        else {
          return const CircularProgressIndicator();
        }
      });
  }
}