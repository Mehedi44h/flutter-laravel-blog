import 'package:flutter/material.dart';
import 'package:flutterlv/screens/login.dart';
import 'package:flutterlv/services/user_service.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: GestureDetector(
          onTap: () {
            logout().then((value) => {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => Login()),
                      (route) => false)
                });
          },
          child: Text('Home:Press to logout')),
    ));
  }
}
