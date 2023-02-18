// ignore: file_names
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:hotel_app/Admin.dart';
import 'package:hotel_app/Staff.dart';
import 'package:hotel_app/Client.dart';

import 'package:hotel_app/model/user_list.dart';
import 'package:hotel_app/service/remote_service.dart';
//login screen
class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  static const String _title = 'Hotel Management System';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const LoginState(),
      ),
    );
  }
}

class LoginState extends StatefulWidget {
  const LoginState({Key? key}) : super(key: key);

  @override
  State<LoginState> createState() => _LoginState();
}

class _LoginState extends State<LoginState> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  List<UserProfile>? users;
  //var isloaded = false;
  //var check = false;
  int number = 0;

  /*@override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    users = await RemotesService().getUserProfile();
    if (users != null) {
      setState(() {
        isloaded = true;
      });
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Login',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Sign in to use your account',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User Name',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                //forgot password screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ForgotPassword()),
                );
              },
              child: const Text(
                'Forgot Password',
              ),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Login'),
                  onPressed: () {
                    debugPrint(nameController.text);
                    debugPrint(passwordController.text);
                    if (nameController.text == 'admin' &&
                        passwordController.text == 'admin') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AdminScreen()),
                      );
                    } else if (nameController.text == 'staff' &&
                        passwordController.text == 'staff') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const StaffScreen()),
                      );
                    } else if (nameController.text == 'client' &&
                        passwordController.text == 'client') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ClientScreen()),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Login Failed"),
                            content: const Text("Please check your username and password"),
                            actions: <Widget>[
                              TextButton(
                                child: const Text("Close"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Does not have account?'),
                TextButton(
                  child: const Text(
                    'Sign in',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    //sign up screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignUp()),
                    );
                  },
                )
              ],
            ),
          ],
        ));
  }
}

//forgot password screen
class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  static const String _title = 'Hotel Management System';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const ForgotPasswordState(),
      ),
    );
  }
}

class ForgotPasswordState extends StatefulWidget {
  const ForgotPasswordState({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordState> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPasswordState> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Forgot Password',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Enter your email to reset your password',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Submit'),
                  onPressed: () {
                    debugPrint(emailController.text);
                    //Return to login screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                    );
                  },
                )),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Does not have account?'),
                TextButton(
                  child: const Text(
                    'Sign in',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    //sign up screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignUp()),
                    );
                  },
                )
              ],
            ),
            const SizedBox(height: 10.0),
          ],
        ));
  }
}

//sign up screen
class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  static const String _title = 'Hotel Management System';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const SignUpState(),
      ),
    );
  }
}

class SignUpState extends StatefulWidget {
  const SignUpState({Key? key}) : super(key: key);

  @override
  State<SignUpState> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpState> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Create your account',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User Name',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Sign Up'),
                  onPressed: () {
                    debugPrint(nameController.text);
                    debugPrint(emailController.text);
                    debugPrint(passwordController.text);
                  },
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Already have account?'),
                TextButton(
                  child: const Text(
                    'Sign in',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    //sign in screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                    );
                  },
                )
              ],
            ),
          ],
        ));
  }
}
