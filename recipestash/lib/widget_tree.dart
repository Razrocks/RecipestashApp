
import 'package:flutter/material.dart';
import 'package:recipestash/classes/authentication.dart';
import 'package:recipestash/pages/home.dart';
import 'package:recipestash/pages/login_register.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
    stream: Authentication().authStateChanges, 
    builder: (context, snapshot){
      if (snapshot.hasData) {
        return Home();
      } else {
        return const LoginRegisterPage();
      }
    });
  }
}