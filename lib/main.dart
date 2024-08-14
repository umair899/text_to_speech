import 'package:flutter/material.dart';
import 'package:text_to_speech/pages/Home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Text to Speech',
      debugShowCheckedModeBanner: false,
      
      home:const HomePage(),
    );
  }
}

