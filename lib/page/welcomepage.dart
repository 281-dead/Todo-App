import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:todo_app/page/homepage.dart';
import 'package:todo_app/page/loginpage.dart';
import 'package:todo_app/page/studentpage.dart';
import 'package:todo_app/page/teacherpage.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  loadLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    switch (prefs.getString('typeofwork')) {
      case 'student':
        Timer(const Duration(seconds: 5), () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const StudentPage()));
        });
        break;
      case 'teacher':
        Timer(const Duration(seconds: 5), () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const TeacherPage()));
        });
        break;
      default:
        Timer(const Duration(seconds: 5), () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
        });
        break;
    }
  }

  @override
  void initState() {
    // TODO: implement initState/
    super.initState();
    loadLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[50],
      body: Center(
        child: SizedBox(
          width: double.infinity,
          height: 100.0,
          child: Shimmer.fromColors(
            baseColor: Colors.red,
            highlightColor: Colors.yellow,
            child: const Text(
              'Organize  your work!!!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
