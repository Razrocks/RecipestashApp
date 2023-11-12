import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkModeEnabled = false; // Filler value
  bool areNotificationsEnabled = false; // Filler value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Settings',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start (left)
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
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
              // Four buttons at the top with different logic
              _buildThemeButton(const Color.fromARGB(255, 33, 54, 243), '', () {
                // Add your logic for the blue theme button here
                print('Blue Theme button pressed');
              }),
              _buildThemeButton(Colors.red, '', () {
                // Add your logic for the red theme button here
                print('Red Theme button pressed');
              }),
              _buildThemeButton(Colors.green, '', () {
                // Add your logic for the green theme button here
                print('Green Theme button pressed');
              }),
              _buildThemeButton(Colors.purple, '', () {
                // Add your logic for the purple theme button here
                print('Purple Theme button pressed');
              }),
            ],
          ),
          SizedBox(height: 16), // Add some spacing between the two rows
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Three buttons under the first three buttons
              _buildSubThemeButton(Colors.lightBlue, '', () {
                // Add your logic for the Light Blue sub-theme button here
                print('Light Blue Sub-Theme button pressed');
              }),
              _buildSubThemeButton(Colors.yellow, '', () {
                // Logic
                print('Yellow Sub-Theme button pressed');
              }),
              _buildSubThemeButton(Colors.white, '', () {
                // Logic
                print('White Sub-Theme button pressed');
              }),
            ],
          ),
          SizedBox(height: 16), // Add some spacing before "Dark Mode" text
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(22.0),
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
                value: isDarkModeEnabled,
                onChanged: (value) {
                  setState(() {
                    isDarkModeEnabled = value;
                  });
                  // Add your Dark Mode switch logic here
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(22.0),
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
                value: areNotificationsEnabled,
                onChanged: (value) {
                  setState(() {
                    areNotificationsEnabled = value;
                  });
                  // Add your Notifications switch logic here
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

  Widget _buildThemeButton(Color color, String label, VoidCallback onPressed) {
    return Container(
      width: 80, // Adjust the width as needed
      height: 50, // Adjust the height as needed
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: color,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildSubThemeButton(Color color, String label, VoidCallback onPressed) {
    return Container(
      width: 80, // Adjust the width as needed
      height: 50, // Adjust the height as needed
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: color,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
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
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SettingsPage(),
  ));
}















