// Import necessary packages and modules
import 'package:flutter/material.dart';
import 'package:recipestash/classes/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';

// LoginRegisterPage class representing the login and registration screen in the Recipe app
class LoginRegisterPage extends StatefulWidget {
  const LoginRegisterPage({Key? key}) : super(key: key);

  @override
  State<LoginRegisterPage> createState() => _LoginRegisterPageState();
}

class _LoginRegisterPageState extends State<LoginRegisterPage> {
  // Variables and controllers for email, password, and error message
  String? errorMessage;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Method to sign in with email and password
  Future<void> signInWithEmailAndPassword() async {
    try {
      await Authentication().signIn(
          email: _emailController.text, password: _passwordController.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  // Method to sign up with email and password
  Future<void> signUpWithEmailAndPassword() async {
    try {
      await Authentication().signUp(
          email: _emailController.text, password: _passwordController.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  // Method to sign in with Google
  Future<void> signInWithGoogle() async {
    try {
      await Authentication().signInGoogle();
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  // Build method to create the UI for the login and registration screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Center(
                child: Padding(
                    padding: const EdgeInsets.only(
                        top: 150.0, left: 20.0, right: 20.0, bottom: 20.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FractionallySizedBox(
                              widthFactor: 0.3,
                              child: Image.asset('assets/images/Icon.png')),
                          const Text('Recipe Stash',
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                  labelText: 'Email',
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(30)))),
                          const SizedBox(height: 10),
                          TextFormField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                  labelText: 'Password',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30))),
                              obscureText: true),
                          Text(errorMessage ?? '',
                              style: const TextStyle(color: Colors.red)),
                          ElevatedButton(
                            onPressed: () async {
                              await signInWithEmailAndPassword();
                            },
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                backgroundColor:
                                    const Color.fromARGB(255, 44, 51, 147)),
                            child: const Text(
                                '                  Login                  '),
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                await signUpWithEmailAndPassword();
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  backgroundColor:
                                      const Color.fromARGB(255, 98, 52, 148)),
                              child: const Text(
                                  '                Sign Up                 ')),
                          SizedBox(
                              width: 280,
                              height: 61,
                              child: IconButton(
                                  onPressed: () async {
                                    await signInWithGoogle();
                                  },
                                  icon: Image.asset(
                                      'assets/images/SignInWithGoogle.png')))
                        ])))));
  }
}
