import 'package:flutter/material.dart';
import 'package:recipestash/classes/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final User? user = Authentication().currentUser;

  // use this to sign out user
  Future<void> signOut() async {
    await Authentication().signOut();
  }

  @override
  Widget build (BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Recipe Stash')),
        body: const Center(
          child: Text('Welcome to Recipe Stash!')
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: signOut,
          tooltip: 'Sign Out',
          child: const Icon(Icons.logout),
        ),
      ),
    );
  }
}