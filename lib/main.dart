import 'package:flutter/material.dart';
import 'view/quizView.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp()
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Quiz Game'),
        backgroundColor: Color(4278190335),
      ),
      body: quizView(),
    );
  }
}
