import 'package:flutter/material.dart';
import 'package:recipestash/main.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: preferences.darkMode == 1 ? Colors.black : Colors.white,
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255,preferences.r!, preferences.g!, preferences.b!),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_sharp, color: Colors.black),
            onPressed: () => Navigator.pop(context)
          ),
          title:  const Text('About', style: TextStyle(color: Colors.black))
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
             ListTile(
              title: Text('Recipe Stash', style: TextStyle(color: preferences.darkMode == 1 ? Colors.white : Colors.black)),
              subtitle: Text('Version 1.0.0', style: TextStyle(color: preferences.darkMode == 1 ? const Color.fromARGB(255, 199, 197, 197) : const Color.fromARGB(255, 150, 148, 148)))
            ),
            ListTile(
              title: Text ('Contact Support', style: TextStyle(color: preferences.darkMode == 1 ? Colors.white : Colors.black)),
              subtitle: GestureDetector(
                onTap: () {launchUrl(Uri.parse('https://github.com/CSCI4100U/mobile-group-project-2023-r-a-t/issues'));},
                child: const Text('Report an issue', style: TextStyle(color: Colors.blue))
              )
            ),
            ListTile(
              title: Text('Developed by', style: TextStyle(color: preferences.darkMode == 1 ? Colors.white : Colors.black)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {launchUrl(Uri.parse('https://github.com/MdTanjeemHaider'));},
                    child: const Text('Md Tanjeem Haider', style: TextStyle(color: Colors.blue))
                  ),
                  const SizedBox(height: 5),
                  GestureDetector(
                    onTap: () {launchUrl(Uri.parse('https://github.com/AymanZahid'));},
                    child: const Text('Ayman Zahid', style: TextStyle(color: Colors.blue))
                  ),
                  const SizedBox(height: 5),
                  GestureDetector(
                    onTap: () {launchUrl(Uri.parse('https://github.com/RazeenOTU'));},
                    child: const Text('Razeen MeeraAmeer', style: TextStyle(color: Colors.blue))
                  )
                ],
              )
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left:16, top: 5),
                child: Text('Copyright © 2023 RAT Ltd', style: TextStyle(color: preferences.darkMode == 1 ? Colors.white : Colors.black))
              )
            )
          ]
        )
      )
    );
  }
}