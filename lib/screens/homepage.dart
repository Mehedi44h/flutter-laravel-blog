import 'package:flutter/material.dart';
import 'package:flutterlv/screens/login.dart';
import 'package:flutterlv/screens/post_form.dart';
import 'package:flutterlv/screens/post_screen.dart';
import 'package:flutterlv/screens/profile.dart';
import 'package:flutterlv/services/user_service.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blog App"),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              logout().then(
                (value) => Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => Login()),
                    (route) => false),
              );
            },
          ),
        ],
      ),
      body: currentIndex == 0 ? PostScreen() : ProfileScreen(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => PostForm(),
              ),
              (route) => false);
        },
        child: Icon(
          Icons.add,
          size: 40,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8,
        clipBehavior: Clip.antiAlias,
        elevation: 10,
        shape: CircularNotchedRectangle(),
        child: BottomNavigationBar(
          backgroundColor: Colors.grey.shade300,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'person'),
          ],
          currentIndex: currentIndex,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
        ),
      ),
    );
  }
}
