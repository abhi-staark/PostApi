import 'package:flutter/material.dart';
import 'package:postapiapp/home.dart';
import 'package:postapiapp/uploadImage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UploadImage(),
    );
  }
}
