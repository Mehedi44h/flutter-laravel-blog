import 'package:flutter/material.dart';
import 'package:flutterlv/constant.dart';
import 'package:flutterlv/screens/homepage.dart';
import 'package:flutterlv/models/api_response.dart';
import 'package:flutterlv/models/user.dart';
import 'package:flutterlv/screens/login.dart';
import 'package:flutterlv/screens/register.dart';
import 'package:flutterlv/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController passwordconfircontroller = TextEditingController();
  bool loading = false;

  void _registerUser() async {
    ApiResponse response = await register(
        namecontroller.text, emailcontroller.text, passwordcontroller.text);
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
        title: Text('Register'),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.all(32),
          children: [
            TextFormField(
              keyboardType: TextInputType.text,
              validator: (value) {
                value!.isEmpty ? 'enter valid name' : null;
              },
              decoration: fielddecor('name'),
            ),
            addh(10),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
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
            TextFormField(
              obscureText: true,
              validator: (value) {
                value!.length < 6 ? 'confirm password does not match' : null;
              },
              decoration: fielddecor('Confirm password'),
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
                          _registerUser();
                        });
                      }
                      print("clicket");
                    },
                    child: Text(
                      "Register",
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
                Text("Already have an account?"),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => Login()),
                        (route) => false);
                  },
                  child: Text(
                    " Login",
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
