import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizapp2/helper/constants.dart';
import 'package:quizapp2/services/auth.dart';
import 'package:quizapp2/services/database.dart';
import 'package:quizapp2/views/home.dart';
import 'package:quizapp2/views/signin.dart';
import 'package:quizapp2/widget/widget.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  AuthService authService = new AuthService();
  DatabaseService databaseService = new DatabaseService();
  final _formKey = GlobalKey<FormState>();

  bool _loading = false;
  String email, pass, name;

  signUp() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _loading = true;
      });

      await authService.signUpEmailAndPass(email, pass).then((value) {
        setState(() {
          _loading = false;
        });

        Map<String, String> userInfo = {
          "userName": name,
          "email": email,
        };

        databaseService.addUserData(userInfo);
        Constants.saveUserLoginSharedPref(userLogin: true);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: AppNameDisplay(),
        brightness: Brightness.light,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: _loading
              ? Container(
                  child: Center(child: CircularProgressIndicator()),
                )
              : Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 400,
                      child: Image(
                        image: AssetImage('images/welcome.jpg'),
                        width: MediaQuery.of(context).size.width - 10,
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Container(
                        child: Column(
                          children: [
                            TextFormField(
                              //Name input
                              validator: (val) =>
                                  val.isEmpty ? "Enter your Name" : null,
                              decoration: InputDecoration(hintText: "Name"),
                              onChanged: (val) {
                                name = val;
                              },
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            TextFormField(
                              //Email input containing @sign
                              validator: (String val) {
                                if (!val.contains('@')) {
                                  return 'Enter valid email';
                                }
                                return null;
                              },
                              decoration: InputDecoration(hintText: "Email"),
                              onChanged: (val) {
                                email = val;
                              },
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            //Password input
                            TextFormField(
                              obscureText: true,
                              validator: (val) => val.length < 6
                                  ? "Password must be 6+ characters"
                                  : null,
                              decoration: InputDecoration(hintText: "Password"),
                              onChanged: (val) {
                                pass = val;
                              },
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            GestureDetector(
                              onTap: () {
                                // print('SignUp Button clicked');
                                signUp();
                              },
                              child: blueColorButton(
                                context: context,
                                buttonContent: 'Sign Up',
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Already have an account? ',
                                  style: TextStyle(
                                      color: Colors.black87, fontSize: 17),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignIn()),
                                    );
                                  },
                                  child: Container(
                                    child: Text(
                                      'Sign In',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          decoration: TextDecoration.underline,
                                          fontSize: 17),
                                    ),
                                  ),
                                ),
                              ],
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
