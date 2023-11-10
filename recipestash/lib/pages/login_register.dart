import 'package:flutter/material.dart';
import 'package:recipestash/classes/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginRegisterPage extends StatefulWidget {
  const LoginRegisterPage({Key? key}) : super(key: key);

  @override
  State<LoginRegisterPage> createState() => _LoginRegisterPageState();
}

class _LoginRegisterPageState extends State<LoginRegisterPage> {
  String? errorMessage;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Authentication().signIn(email: _emailController.text, password: _passwordController.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> signUpWithEmailAndPassword() async
  {
    try {
      await Authentication().signUp(email: _emailController.text, password: _passwordController.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> signInWithGoogle() async
  {
    try {
      await Authentication().signInGoogle();
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Stash'),
      ),
      body: SingleChildScrollView(
        child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              FractionallySizedBox(widthFactor: 0.3, child: Image.asset('assets/images/Icon.png')),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email',),
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              Text(errorMessage ?? '', style: const TextStyle(color: Colors.red)),
              ElevatedButton(onPressed: () async {await signInWithEmailAndPassword();}, child: const Text('Login')),
              ElevatedButton(onPressed: () async {await signUpWithEmailAndPassword();}, child: const Text('Sign Up')),
              ElevatedButton(onPressed: () async {await signInWithGoogle();}, child: const Text('Sign In with Google')),
            ],
          )
        ),
      ),
      )
    );
  }
}