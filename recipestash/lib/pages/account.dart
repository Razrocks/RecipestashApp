import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipestash/classes/authentication.dart';
import 'package:recipestash/classes/recipe_model.dart';

class Account extends StatelessWidget {
  const Account({Key? key}) : super(key: key);

  Future<void> signOut() async {
    await Authentication().signOut();
  }

  void deleteAllRecipe() {
    RecipeModel().deleteAllRecipe();
  }

  @override
  Widget build(BuildContext context) {
    final User? user = Authentication().currentUser;

    bool isGoogleUser = user?.providerData[0].providerId == "google.com";

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Account",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                isGoogleUser
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(user?.photoURL ?? ''),
                        radius: 40)
                    : const Icon(Icons.account_circle, size: 80),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user!.displayName!,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Text(user.email!, style: const TextStyle(fontSize: 15))
                  ],
                )
              ],
            ),
          ),
          // const Divider(),
          TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Delete all recipes?"),
                    content: const Text("This action cannot be undone."),
                    actions: [
                      TextButton(
                        onPressed: (){Navigator.pop(context);},
                        child: const Text("No")
                      ),
                      TextButton(
                        onPressed: () {
                          deleteAllRecipe();
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Deleted all recipes!")));
                        },
                        child: const Text("Yes")
                      )
                    ],
                  );
                }
              );
            },
            style: TextButton.styleFrom(alignment: Alignment.centerLeft),
            child: const Text('Delete all recipes'),
          ),
          TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Sign out"),
                    content: const Text("Are you sure you want to sign out?"),
                    actions: [
                      TextButton(
                        onPressed: (){Navigator.pop(context);},
                        child: const Text("No")
                      ),
                      TextButton(
                        onPressed: () {
                          signOut();
                          Navigator.pop(context);
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Signed out successfully!")));
                        },
                        child: const Text("Yes")
                      )
                    ],
                  );
                });
            },
            style: TextButton.styleFrom(alignment: Alignment.centerLeft),
            child: const Text('Sign out')
          ),
        ],
      ),
    );
  }
}