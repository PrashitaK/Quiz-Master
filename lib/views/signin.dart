import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizapp2/helper/constants.dart';
import 'package:quizapp2/services/auth.dart';
import 'package:quizapp2/views/home.dart';
import 'package:quizapp2/views/signup.dart';
import 'package:quizapp2/widget/widget.dart';

class SignIn extends StatefulWidget {
  // final Function toogleView;
  // SignIn({this.toogleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();

  String email;
  String pass;

  final AuthService _authService = AuthService();

  bool _loading = false;

  signIn() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        //when user is signing in
        _loading = true;
      });

      await _authService.signInEmailAndPass(email, pass).then((val) {
        if (val != null) {
          setState(() {
            _loading = false;
          });

          Constants.saveUserLoginSharedPref(userLogin: true);

          Navigator.pushReplacement(
              //send user to home screen when signed in
              context,
              MaterialPageRoute(builder: (context) => Home()));
        }
      });
    } else {
      print("Error occured");
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: AppNameDisplay(),
        brightness: Brightness.light,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: _loading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      height: 350,
                      child: Image(
                        image: AssetImage('images/login.jpg'),
                      ),
                    ),
                    SizedBox(
                      height: 70,
                    ),
                    Form(
                      key: _formKey,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          children: [
                            Container(
                              child: Column(
                                children: [
                                  //input email from user which should contain @
                                  TextFormField(
                                    validator: (String val) {
                                      if (!val.contains('@')) {
                                        return 'Enter valid email';
                                      }
                                      return null;
                                    },
                                    decoration:
                                        InputDecoration(hintText: 'Email'),
                                    onChanged: (val) {
                                      email = val;
                                    },
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  //input password
                                  TextFormField(
                                    obscureText: true, //hide password
                                    validator: (val) {
                                      return val.isEmpty
                                          ? 'Enter password'
                                          : null;
                                    },
                                    decoration:
                                        InputDecoration(hintText: 'Password'),
                                    onChanged: (val) {
                                      pass = val;
                                    },
                                  ),
                                  SizedBox(
                                    height: 24,
                                  ),
                                  //signin button
                                  GestureDetector(
                                    onTap: () {
                                      // print('Signin button click');
                                      signIn();
                                    },
                                    child: blueColorButton(
                                        context: context,
                                        buttonContent: 'Sign in'),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Don't have an account? ",
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SignUp()));
                                        },
                                        child: Text(
                                          'Sign Up',
                                          style: TextStyle(
                                            fontSize: 15,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
