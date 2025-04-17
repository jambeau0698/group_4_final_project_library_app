import 'package:flutter/material.dart';
import 'package:group_4_final_project_library_app/core/user_logged_in.dart';
import 'package:group_4_final_project_library_app/core/db_helper.dart';
import 'package:group_4_final_project_library_app/models/Student.dart';
import 'package:group_4_final_project_library_app/core/app_theme.dart';
import 'package:group_4_final_project_library_app/views/books_page.dart';


class LoginPage extends StatefulWidget{
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage>{
  final loginForm = GlobalKey<FormState>();
  
  final studentNumber = TextEditingController();
  final password = TextEditingController();
  
  String errorMessage = "";
  
  void login() async {
    final studentNumberCheck = studentNumber.text.trim();
    final passwordCheck = password.text.trim();
    
    if (studentNumberCheck.isEmpty || passwordCheck.isEmpty){
      setState(() {
        errorMessage = "Must enter all fields";
      });
      return;
    }
    final student = await DBHelper.dblibrary.getStudentForLogin(studentNumberCheck, passwordCheck);
  if (!context.mounted) return;
    if (student != null){
      LoggedInUser.loggedIn = student.id!;
      setState(() {
        errorMessage = '';
      });
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => BooksPage()),
      );

    }
    else{
      setState(() {
        errorMessage = "error logging in";
      });
    }
  }
  @override
  Widget build(BuildContext context){
    return Theme(data: AppTheme.lightTheme,
        child: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
          body: Padding(
              padding: EdgeInsets.all(15),
          child: Form(
              key: loginForm,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (errorMessage.isNotEmpty)
                Text(
                  errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              TextFormField(
                controller: studentNumber,
                decoration: InputDecoration(labelText: 'Student Number'),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: password,
                decoration: const InputDecoration(labelText: 'Password'),

              ),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: login,
                  child: Text('Login'),
              ),
            ],
          ),),
          ),
        )
    );
  }
}
