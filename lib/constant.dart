// string
import 'package:flutter/material.dart';

const baseURL = 'http://192.168.43.109:8000/api';
const loginURL = baseURL + '/login';
const registerURL = baseURL + '/register';
const logoutURL = baseURL + '/logout';
const userURL = baseURL + '/user';
const postsURL = baseURL + '/posts';
const commentURL = baseURL + '/comments';

// errors
const serverError = 'Server error';
const unauthrized = 'Unauthorized';
const somethingWentWrong = 'Something Went Wrong';
// inpute decoration
InputDecoration fielddecor(String labeltxt) {
  return InputDecoration(
    labelText: labeltxt,
    contentPadding: EdgeInsets.all(10),
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black87,
        width: 1,
      ),
    ),
  );
}

SizedBox addh(double h) {
  return SizedBox(
    height: h,
  );
}

// custome button
// class txtbtn extends StatelessWidget {}
//   final String txt;
//   final Function onpss;
//   const txtbtn({super.key, required this.txt, required this.onpss});

//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//       onPressed: () {},
//       child: Text(
//         "Login",
//         style: TextStyle(
//           color: Colors.white,
//         ),
//       ),
//       style: ButtonStyle(
//         backgroundColor:
//             MaterialStateColor.resolveWith((states) => Colors.blue),
//         padding: MaterialStateProperty.resolveWith(
//           (states) => EdgeInsets.symmetric(vertical: 15),
//         ),
//       ),
//     );
//   }
// }
