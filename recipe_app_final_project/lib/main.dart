import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe App',
      home: RecipeListScreen(),
    );
  }
}

class RecipeListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe App'),
      ),
      body: RecipeList(),
      drawer: AppDrawer(), // Add the drawer here.
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RecipeSubmissionScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class RecipeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // This is where you can fetch and display a list of recipes.
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text('Recipe 1'),
        ),
        ListTile(
          title: Text('Recipe 2'),
        ),
        // Add more list items as needed.
      ],
    );
  }
}

class RecipeSubmissionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Submit a Recipe'),
      ),
      body: RecipeSubmissionForm(),
    );
  }
}

class RecipeSubmissionForm extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController ingredientsController = TextEditingController();
  final TextEditingController instructionsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          TextField(
            controller: titleController,
            decoration: InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: ingredientsController,
            decoration: InputDecoration(labelText: 'Ingredients'),
            maxLines: 3,
          ),
          TextField(
            controller: instructionsController,
            decoration: InputDecoration(labelText: 'Instructions'),
            maxLines: 5,
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Implement the code to submit the recipe here.
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName:
                Text('John Doe'), // Replace with the user's account name
            accountEmail:
                Text('johndoe@example.com'), // Replace with the user's email
            currentAccountPicture: CircleAvatar(
              // Replace with the user's profile picture
              backgroundImage: AssetImage('assets/profile_picture.png'),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Recipe Browser'),
            onTap: () {
              // Implement the action for Recipe Browser.
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Favorites'),
            onTap: () {
              // Implement the action for Favorites.
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              // Implement the action for Settings.
            },
          ),
          // Add more options as needed.
        ],
      ),
    );
  }
}
