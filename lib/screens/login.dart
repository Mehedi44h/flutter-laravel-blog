import 'package:flutter/material.dart';
import 'package:flutterlv/constant.dart';
import 'package:flutterlv/homepage.dart';
import 'package:flutterlv/models/api_response.dart';
import 'package:flutterlv/models/user.dart';
import 'package:flutterlv/screens/register.dart';
import 'package:flutterlv/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  bool loading = false;

  void _loginUser() async {
    ApiResponse response =
        await login(emailcontroller.text, passwordcontroller.text);
    if (response.error == null) {
      _saveAndRedirectToHome(response.data as User);
    } else {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${response.error}'),
        ),
      );
    }
  }

  void _saveAndRedirectToHome(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setInt('userId', user.id ?? 0);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => MyHomePage()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.all(32),
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                // if (value == null || value.isEmpty) {
                //   return 'Please enter some text';
                // }
                // return null;
                value!.isEmpty ? 'enter valid email' : null;
              },
              decoration: fielddecor('email'),
            ),
            addh(20),
            TextFormField(
              obscureText: true,
              validator: (value) {
                value!.length < 6 ? 'required at least 6 char' : null;
              },
              decoration: fielddecor('password'),
            ),
            addh(10),
            loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : TextButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          loading = true;
                          _loginUser();
                        });
                      }
                      print("clicket");
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.blue),
                      padding: MaterialStateProperty.resolveWith(
                        (states) => EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ),
            addh(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?"),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => Register()),
                        (route) => false);
                  },
                  child: Text(
                    " Register",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 15,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
