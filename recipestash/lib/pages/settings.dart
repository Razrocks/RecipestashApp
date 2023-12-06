import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:recipestash/classes/preferences_model.dart';
import 'package:recipestash/main.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Color selectedThemeColor = Color.fromARGB(255, preferences.r!, preferences.g!, preferences.b!); // Default theme color

  Widget _buildThemeButton(Color color) {
    return SizedBox(
      width: 80,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          changeColor(color);
          setState(() {
            selectedThemeColor = color;
          });
        },
        child: null,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
        ),
      ),
    );
  }

  void changeColor(Color color) {
    setState(() {
      preferences.r = color.red;
      preferences.g = color.green;
      preferences.b = color.blue;

      PreferencesModel().update(preferences);
    });
    print(preferences);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB( 255,preferences.r!, preferences.g!, preferences.b!),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Themes',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildThemeButton(const Color.fromARGB(255, 33, 54, 243)),
              _buildThemeButton(const Color.fromARGB(255, 223, 0, 0)),
              _buildThemeButton(const Color.fromARGB(255, 18, 175, 18)),
              _buildThemeButton(const Color.fromARGB(255, 119, 13, 224)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildThemeButton(const Color.fromARGB(255, 103, 202, 248)),
              _buildThemeButton(const Color.fromARGB(255, 255, 251, 0)),
              Container(
                width: 80,
                height: 50,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Colors.red,
                        Colors.yellow,
                        Colors.green,
                        Colors.blue,
                        Colors.pink
                      ],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Pick a color!'),
                          content: SingleChildScrollView(
                            child: ColorPicker(
                                pickerColor: Color.fromARGB(
                                    255, preferences.r!, preferences.g!, preferences.b!),
                                onColorChanged: changeColor),
                          ),
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(0, 0, 0, 0)),
                  child: const Icon(Icons.colorize_sharp),
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.all(22.0),
                child: Text(
                  'Dark Mode',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Switch(
                activeColor: Color.fromARGB( 255,preferences.r!, preferences.g!, preferences.b!),
                value: preferences.darkMode == 1 ? true : false,
                onChanged: (value) {
                  setState(() {
                    preferences.darkMode = value ? 1 : 0;
                    PreferencesModel().update(preferences);
                  });
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.all(22.0),
                child: Text(
                  'Notifications',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Switch(
                activeColor: Color.fromARGB( 255,preferences.r!, preferences.g!, preferences.b!),
                value: preferences.notifications == 1 ? true : false,
                onChanged: (value) {
                  setState(() {
                    preferences.notifications = value ? 1 : 0;
                    PreferencesModel().update(preferences);
                  });
                },
              ),
            ],
          ),
          // Move text buttons to the left
          Padding(
            padding: const EdgeInsets.only(left: 0.0),
            child: _buildTextButton('Feedback', () {
              // Add your Feedback button logic here
              print('Feedback button pressed');
            }),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 0.0),
            child: _buildTextButton('Share App', () {
              // Add your Share App button logic here
              print('Share App button pressed');
            }),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 0.0),
            child: _buildTextButton('About', () {
              // Add your About button logic here
              print('About button pressed');
            }),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 0.0),
            child: _buildTextButton('Help', () {
              // Add your Help button logic here
              print('Help button pressed');
            }),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 0.0),
            child: _buildTextButton('Terms & Service', () {
              // Add your Terms & Service button logic here
              print('Terms & Service button pressed');
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildTextButton(String text, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
