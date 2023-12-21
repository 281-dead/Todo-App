import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:todo_app/page/homepage.dart';
import 'package:todo_app/page/studentpage.dart';
import 'package:todo_app/page/teacherpage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String typeOfWork = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF764ABC),
        title: const Text('Login'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  label: Text('Email'),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                controller: passwordController,
                autofocus: true,
                decoration: const InputDecoration(
                  label: Text('Password'),
                ),
              ),
            ),
            RadioListTile(
                title: const Text('Student', style: TextStyle(fontSize: 20)),
                value: 'student',
                groupValue: typeOfWork,
                onChanged: (value) {
                  setState(() {
                    typeOfWork = value.toString();
                  });
                }),
            RadioListTile(
                title: const Text('Teacher', style: TextStyle(fontSize: 20)),
                value: 'teacher',
                groupValue: typeOfWork,
                onChanged: (value) {
                  setState(() {
                    typeOfWork = value.toString();
                  });
                }),
            RadioListTile(
                title: const Text('Other', style: TextStyle(fontSize: 20)),
                value: 'other',
                groupValue: typeOfWork,
                onChanged: (value) {
                  setState(() {
                    typeOfWork = value.toString();
                  });
                }),
            const SizedBox(height: 20),
            SizedBox(
              width: 300,
              height: 50,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      )),
                  onPressed: () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setString('email', emailController.text.toString());
                    prefs.setString('password', passwordController.text.toString());
                    prefs.setString('typeofwork', typeOfWork);
                    //print(prefs.getString('email'));
                    switch (prefs.getString('typeofwork')) {
                      case 'student':
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const StudentPage()));
                        break;
                      case 'teacher':
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const TeacherPage()));
                        break;
                      default:
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
                        break;
                    }
                  },
                  child: const Text(
                    'SignUp',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.center,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
