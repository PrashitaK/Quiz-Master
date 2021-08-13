import 'package:flutter/material.dart';
import 'package:quizapp2/helper/constants.dart';
import 'package:quizapp2/views/home.dart';
import 'package:quizapp2/views/signin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // Root of app
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userLogin = false; // checking to see if the user is logged in or not

  @override
  void initState() {
    getLoginState();
    super.initState();
  }

  //get user login status and work accordingly
  getLoginState() async {
    await Constants.getUserLoginSharedPref().then((value) {
      setState(() {
        print("getUserLoggedInSharedPreference: $value");
        userLogin = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz Master',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: (userLogin ?? false) ? Home() : SignIn(), 
    );
  }
}
