import 'package:flutter/material.dart';
import 'package:group_4_final_project_library_app/core/app_theme.dart';
import 'package:group_4_final_project_library_app/core/app_colors.dart';
import 'package:group_4_final_project_library_app/core/db_helper.dart';
import 'package:group_4_final_project_library_app/models/db_result.dart';
import 'package:group_4_final_project_library_app/models/Student.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final signupForm = GlobalKey<FormState>();

  final studentNumber = TextEditingController();
  final fullName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final program = TextEditingController();

  String? selectYear = '1';
  bool currentStudent = true;

  void submitForm() async {
    if (signupForm.currentState!.validate()) {
      final studentDetails = {
        'studentNumber': studentNumber.text,
        'fullname': fullName.text,
        'email': email.text,
        'password': password.text,
        'program': program.text,
        'year': currentStudent ? selectYear : 'Graduated',
      };
      DBResult result = await DBHelper.dblibrary.addStudent(studentDetails);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result.message)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
        backgroundColor: appColors.primary,
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: signupForm,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: studentNumber,
                decoration: InputDecoration(labelText: 'Student Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Must enter Student Number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: fullName,
                decoration: InputDecoration(labelText: 'Full Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Must enter Name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: email,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Must enter Email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: password,
                decoration: InputDecoration(labelText: 'Password'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Must enter Password';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: program,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Must enter Program';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              Text("Are you currently enrolled?"),
              Row(
                children: [
                  Radio<bool>(
                    value: true,
                    groupValue: currentStudent,
                    onChanged: (bool? value) {
                      setState(() {
                        currentStudent = value ?? true;
                      });
                    },
                  ),
                  Text("Yes"),
                  Radio<bool>(
                      value: false,
                      groupValue: currentStudent,
                      onChanged: (bool? value) {
                        setState(() {
                          currentStudent = value ?? false;
                        });
                      }),
                  Text("No"),
                ],
              ),
              if (currentStudent)
                DropdownButtonFormField<String>(
                  value: selectYear,
                  decoration: InputDecoration(labelText: "current Year"),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectYear = newValue!;
                    });
                  },
                  items: ['1', '2', '3', '4']
                      .map((year) => DropdownMenuItem(
                            value: year,
                            child: Text("Year $year"),
                          ))
                      .toList(),
                ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: submitForm, child: Text("Finish")),
            ],
          ),
        ),
      ),
    );
  }
}
