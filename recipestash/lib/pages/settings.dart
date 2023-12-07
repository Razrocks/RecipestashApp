import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:recipestash/classes/preferences_model.dart';
import 'package:recipestash/main.dart';
import 'package:recipestash/pages/about.dart';
import 'package:url_launcher/url_launcher.dart';

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

  void showTermsOfService() {
    const String termsOfService = '''
      Terms of Service

      1. Acceptance of Terms

      By accessing or using the [Your Recipe App Name] (the "App"), you agree to comply with and be bound by these Terms of Service ("Terms"). If you do not agree to these Terms, please do not use the App.

      2. Use of the App

      a. Eligibility: You must be at least 13 years old to use the App. By using the App, you represent and warrant that you are 13 years of age or older.

      b. User Account: You may need to create a user account to access certain features of the App. You are responsible for maintaining the confidentiality of your account information and are fully responsible for all activities that occur under your account.

      3. Content

      a. User-Generated Content: You may submit recipes, comments, or other content ("User Content") to the App. By submitting User Content, you grant Recipe Stash a non-exclusive, royalty-free, worldwide, perpetual, and irrevocable right to use, reproduce, modify, adapt, publish, distribute, and display such User Content.

      b. Content Ownership: Recipe Stash does not claim ownership of User Content. However, by submitting User Content, you represent that you have the right to grant the license mentioned in Section 3(a).

      4. Prohibited Conduct

      You agree not to:

      a. Use the App for any unlawful purpose or in violation of any applicable laws.

      b. Post, upload, or distribute any content that is defamatory, obscene, or violates the rights of others.

      c. Attempt to interfere with the proper functioning of the App.

      5. Termination

      Recipe Stash reserves the right to suspend or terminate your access to the App at any time for any reason without notice.

      6. Privacy Policy

      Your use of the App is also governed by our Privacy Policy, which can be found at [link to your privacy policy].

      7. Changes to Terms

      Recipe Stash reserves the right to modify or update these Terms at any time. Your continued use of the App after any such changes constitutes your acceptance of the new Terms.

      8. Disclaimer of Warranties

      The App is provided on an "as-is" and "as available" basis. Recipe Stash makes no warranties, express or implied, regarding the accuracy, completeness, reliability, or suitability of the App.

      9. Limitation of Liability

      Recipe Stash shall not be liable for any indirect, incidental, special, consequential, or punitive damages, or any loss of profits or revenues, whether incurred directly or indirectly.

      10. Governing Law

      These Terms are governed by and construed in accordance with the laws of [Your Country/State], without regard to its conflict of law principles.

      Contact Us

      If you have any questions or concerns about these Terms, please contact us at [your contact email].
    ''';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Terms of Service'),
          content: const SingleChildScrollView(
            child: Text(termsOfService)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              }, 
              child: const Text('Close')
            )
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: preferences.darkMode == 1 ? Colors.black : Colors.white,
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
           Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Themes',
              style: TextStyle(
                color: preferences.darkMode == 1 ? Colors.white : Colors.black,
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
          // const SizedBox(height: 16), // Add some spacing before "Dark Mode" text
          ListTile(
            title: Text('Dark Mode', style: TextStyle(color: preferences.darkMode == 1 ? Colors.white : Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
            trailing: Switch(
              activeColor: Color.fromARGB(255, preferences.r!, preferences.g!, preferences.b!),
              value: preferences.darkMode == 1 ? true : false,
              onChanged: (value) {
                setState(() {
                  preferences.darkMode = value ? 1 : 0;
                  PreferencesModel().update(preferences);
                });
                // Add your Dark Mode switch logic here
              },
            ),
          ),
          ListTile(
            title: Text('Notifications', style: TextStyle(color: preferences.darkMode == 1 ? Colors.white : Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
            trailing: Switch(
              activeColor: Color.fromARGB(255, preferences.r!, preferences.g!, preferences.b!),
              value: preferences.notifications == 1 ? true : false,
              onChanged: (value) {
                setState(() {
                  preferences.notifications = value ? 1 : 0;
                });
                // Add your Notifications switch logic here
              },
            ),
          ),
          ListTile(
            title: Text('Feedback', style: TextStyle(color: preferences.darkMode == 1 ? Colors.white : Colors.black)),
            onTap: () {
              launchUrl(Uri.parse('https://docs.google.com/forms/d/e/1FAIpQLSda-c0Um9eXByoxABmyTduXTPzIcB6qGMheAoEjGTLVVREj1g/viewform?usp=sf_link'));
            },
            trailing: Icon(Icons.feedback_outlined, color: preferences.darkMode == 1 ? Colors.white : Colors.black,),
          ),
          ListTile(
            title: Text('Share App', style: TextStyle(color: preferences.darkMode == 1 ? Colors.white : Colors.black)),
            onTap: () {
              FlutterShare.share(
                title: 'Try out this App!', 
                text: 'Hey try out this app! It\'s called Recipe Stash and it\'s awesome!', 
                linkUrl: 'https://github.com/CSCI4100U/mobile-group-project-2023-r-a-t/releases/latest');
            },
            trailing: Icon(Icons.share_outlined, color: preferences.darkMode == 1 ? Colors.white : Colors.black,),
          ),
          ListTile(
            title: Text('About', style: TextStyle(color: preferences.darkMode == 1 ? Colors.white : Colors.black)),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const About()));
            },
            trailing: Icon(Icons.info_outline, color: preferences.darkMode == 1 ? Colors.white : Colors.black,),
          ),
          ListTile(
            title: Text('Help', style: TextStyle(color: preferences.darkMode == 1 ? Colors.white : Colors.black)),
            onTap: () {
              launchUrl(Uri.parse('https://github.com/CSCI4100U/mobile-group-project-2023-r-a-t/discussions'));
            },
            trailing: Icon(Icons.help_outline, color: preferences.darkMode == 1 ? Colors.white : Colors.black,),
          ),
          ListTile(
            title: Text('Terms of Service', style: TextStyle(color: preferences.darkMode == 1 ? Colors.white : Colors.black)),
            onTap: () {
              showTermsOfService();
            },
            trailing: Icon(Icons.description_outlined, color: preferences.darkMode == 1 ? Colors.white : Colors.black,),

          ),
        ],
      ),
    );
  }
}
