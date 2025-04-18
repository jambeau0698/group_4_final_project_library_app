import 'dart:async';
import 'package:flutter/material.dart';
import 'package:group_4_final_project_library_app/views/login_page.dart';
import 'package:group_4_final_project_library_app/core/db_helper.dart'; // <- DBHelper import

class splashPage extends StatefulWidget {
  const splashPage({Key? key}) : super(key: key);

  @override
  State<splashPage> createState() => _splashPageState();
}

class _splashPageState extends State<splashPage> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {

    await DBHelper.dblibrary.libraryDatabase;


    await DBHelper.dblibrary.addBooks();

    // Delay before navigating to Login Pag
    await Future.delayed(const Duration(seconds: 3));

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Image.network(
                'https://www.lucansouthparish.net/wp-content/uploads/2021/07/Welcome.jpg',
            width: 300,
            height: 200,),
            const SizedBox(height: 20),
            const Text(
              "Welcome to our Library",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
