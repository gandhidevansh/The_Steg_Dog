import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' as Io;
import 'dart:ui';
import 'dart:core';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'SavePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Io.File _image;
  var pickedFile = null;
  var Done = null;
  Widget image = null;
  var _base64 = null;
  final picker = ImagePicker();
  TextEditingController secret = new TextEditingController();
  Future getImage(int a) async {
    if (a == 1) {
      pickedFile = await picker.getImage(source: ImageSource.camera);
    } else {
      pickedFile = await picker.getImage(source: ImageSource.gallery);
    }

    setState(() {
      if (pickedFile != null) {
        _image = Io.File(pickedFile.path);
        print(_image);
      } else {
        print('No image selected.');
      }
    });
  }

  Future success() async {
    Fluttertoast.showToast(
        msg: "Successfully Encoded the Image!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        //timeInSecForIos: 3,
        backgroundColor: Colors.blueAccent,
        textColor: Colors.white,
        fontSize: 16.0);
    print("ABOUT TO");
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => SavePage(imgbyte: _base64)));
  }

  Future _upload_e() async {
    Response response;
    var dio = Dio();
    if (_image == null) {
      print("No file chosen yet!");
    } else {
      final bytes = Io.File(pickedFile.path).readAsBytesSync();
      String img64 = base64Encode(bytes);
      response = await dio.post('https://6d6f54205d67.ngrok.io/encode',
          data: {'text': secret.text, 'img': img64});
      if (response.statusCode == 200) {
        _base64 = response.data.toString();
        success();
      } else {
        print("Some Error Occurred!");
      }
    }
  }

  Future _upload_d() async {
    Response response;
    var dio = Dio();
    if (_image == null) {
      print("No file chosen yet!");
    } else {
      final bytes = Io.File(pickedFile.path).readAsBytesSync();
      String img64 = base64Encode(bytes);
      response = await dio
          .post('https://6d6f54205d67.ngrok.io/decode', data: {'img': img64});
      if (response.statusCode == 200) {
        _base64 = response.data.toString();
        success();
      } else {
        print("Some Error Occurred!");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("The Steg Dog"),
      ),
      body: Column(
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.green),
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                    primary: Colors.white,
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    print("Pressing encode~~");
                    // ignore: unnecessary_statements
                    _upload_e();
                  },
                  child: const Text('Encode'),
                ),
              ),
              Container(
                margin: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.black),
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                    primary: Colors.white,
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    _upload_d();
                  },
                  child: const Text('Decode'),
                ),
              ),
            ],
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: _image == null
                      ? Text(
                          'No image selected.',
                        )
                      : Image.file(
                          _image,
                          height: 250.0,
                          width: 250.0,
                        ),
                ),
              ),
            ],
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(25),
                  child: TextField(
                    controller: secret,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Secret message',
                      hintText: 'Enter the Secret Message if Encoding',
                    ),
                  ),
                ),
              ),
            ],
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                    primary: Colors.black,
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    getImage(2);
                  },
                  child: const Text('Choose from Gallery'),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          getImage(1);
        },
        icon: Icon(Icons.camera),
        label: Text("Capture"),
      ),
    );
  }
}
