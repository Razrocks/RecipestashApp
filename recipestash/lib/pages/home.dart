import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build (BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Recipe Stash')),
        body: const Center(
          child: Text('Welcome to Recipe Stash!'),
        ),
      ),
    );
  }
}