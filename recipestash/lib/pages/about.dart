import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_sharp),
            onPressed: () => Navigator.pop(context)
          ),
          title: const Text('About')
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const ListTile(
              title: Text('Recipe Stash'),
              subtitle: Text('Version 1.0.0'),
            ),
            ListTile(
              title: const Text ('Contact Support'),
              subtitle: GestureDetector(
                onTap: () {
                  launchUrl(Uri.parse('https://github.com/CSCI4100U/mobile-group-project-2023-r-a-t/issues'));},
                child: const Text('Report an issue', style: TextStyle(color: Colors.blue))
              )
            ),
            ListTile(
              title: const Text('Developed by'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {launchUrl(Uri.parse('https://github.com/MdTanjeemHaider'));},
                    child: const Text('Md Tanjeem Haider', style: TextStyle(color: Colors.blue)),
                  ),
                  const SizedBox(height: 5),
                  GestureDetector(
                    onTap: () {launchUrl(Uri.parse('https://github.com/AymanZahid'));},
                    child: const Text('Ayman Zahid', style: TextStyle(color: Colors.blue)),
                  ),
                  const SizedBox(height: 5),
                  GestureDetector(
                    onTap: () {launchUrl(Uri.parse('https://github.com/RazeenOTU'));},
                    child: const Text('Razeen MeeraAmeer', style: TextStyle(color: Colors.blue)),
                  )
                ],
              )
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left:16, top: 5),
                child: Text('Copyright © 2023 RAT Ltd', style: TextStyle(color: Colors.grey),),
              )
            )
          ],
        )
      )
    );
  }
}