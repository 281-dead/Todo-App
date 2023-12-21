import 'package:flutter/material.dart';
import 'package:todo_app/page/welcomepage.dart';
import './page/homepage.dart';

void main() {
  runApp(const toDoApp());
}

class toDoApp extends StatelessWidget {
  const toDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
    );
  }
}
