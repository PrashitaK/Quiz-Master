import 'package:flutter/material.dart';
import 'package:quizapp2/services/database.dart';
import 'package:quizapp2/views/add_question.dart';
import 'package:quizapp2/widget/widget.dart';
import 'package:random_string/random_string.dart';

class CreateQuiz extends StatefulWidget {
  @override
  _CreateQuizState createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  DatabaseService databaseService = new DatabaseService();
  final _formKey = GlobalKey<FormState>();

  String quizImageDisplayUrl, quizTitle, quizDesc;

  bool _loading = false;
  String quizId;

  createQuiz() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _loading = true;
      });

      // create a random quizID which can be accessed later.
      quizId = randomAlphaNumeric(16);

      Map<String, String> quizMapData = {
        'quizId': quizId,
        "quizImgUrl": quizImageDisplayUrl,
        "quizTitle": quizTitle,
        "quizDesc": quizDesc,
      };

      await databaseService.addQuizData(quizMapData, quizId).then((value) {
        setState(() {
          _loading = false;
        });
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => AddQuestion(quizId)));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black54,
        ),
        title: AppNameDisplay(),
        centerTitle: true,
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
          : Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Create your own Quiz!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      //to give vertical space
                      height: 40,
                    ),
                    // quiz display iamge url input
                    TextFormField(
                      validator: (val) =>
                          val.isEmpty ? "Enter Quiz Image Url" : null,
                      decoration: InputDecoration(hintText: "Quiz Image Url"),
                      onChanged: (val) {
                        quizImageDisplayUrl = val;
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    // Quiz title input
                    TextFormField(
                      validator: (val) =>
                          val.isEmpty ? "Enter Quiz Title" : null,
                      decoration: InputDecoration(hintText: "Quiz Title"),
                      onChanged: (val) {
                        quizTitle = val;
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    //Quiz Description input
                    TextFormField(
                      validator: (val) =>
                          val.isEmpty ? "Enter Quiz Description" : null,
                      decoration: InputDecoration(hintText: "Quiz Description"),
                      onChanged: (val) {
                        quizDesc = val;
                      },
                      //have a multiline input in description
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                    ),
                    Spacer(),
                    // Create Quiz button
                    GestureDetector(
                      onTap: () {
                        createQuiz();
                      },
                      child: blueColorButton(
                          context: context, buttonContent: 'Create Quiz'),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
