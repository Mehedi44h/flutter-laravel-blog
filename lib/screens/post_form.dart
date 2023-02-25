import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutterlv/constant.dart';
import 'package:flutterlv/models/api_response.dart';
import 'package:flutterlv/screens/login.dart';
import 'package:flutterlv/services/post_service.dart';
import 'package:flutterlv/services/user_service.dart';
import 'package:image_picker/image_picker.dart';

class PostForm extends StatefulWidget {
  const PostForm({Key? key}) : super(key: key);

  @override
  State<PostForm> createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController txtControllerBody = TextEditingController();
  bool _loading = false;
  File? _imageFile;
  final _picker = ImagePicker();

  Future getImage() async {
    final pickedfile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedfile != null) {
      setState(() {
        _imageFile = File(pickedfile.path);
      });
    }
  }

  void _createPost() async {
    String? image = _imageFile == null ? null : getStringImage(_imageFile);
    ApiResponse response = await createPost(txtControllerBody.text, image);
    if (response.error == null) {
      Navigator.of(context).pop();
    } else if (response.error == unauthrized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Login()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$response.error'),
        ),
      );
      setState(() {
        _loading = !_loading;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new post'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            decoration: BoxDecoration(
              image: _imageFile == null
                  ? null
                  : DecorationImage(
                      image: FileImage(
                        _imageFile ?? File(''),
                      ),
                      fit: BoxFit.cover,
                    ),
            ),
            child: Center(
              child: IconButton(
                onPressed: () {
                  getImage();
                },
                icon: Icon(
                  Icons.image,
                  size: 50,
                  color: Colors.black38,
                ),
              ),
            ),
          ),
          Form(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                key: _formKey,
                controller: txtControllerBody,
                keyboardType: TextInputType.multiline,
                maxLines: 9,
                validator: (value) {
                  value!.isEmpty ? 'post body required ' : null;
                },
                decoration: InputDecoration(
                  hintText: 'write here post body...',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.black38,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    _loading = !_loading;
                  });
                  _createPost();
                }
              },
              child: Text(
                "Post",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.blue),
                padding: MaterialStateProperty.resolveWith(
                  (states) => EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
