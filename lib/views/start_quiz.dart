import 'package:flutter/material.dart';
import 'package:quizapp2/views/quiz_play.dart';
import 'package:quizapp2/widget/widget.dart';

class StartQuiz extends StatefulWidget {
  final String quizId;
  final String title;
  final String desc;
  final String imageUrl;
  final int count;

  StartQuiz({
    @required this.quizId,
    @required this.title,
    @required this.desc,
    @required this.imageUrl,
    @required this.count,
  });
  @override
  _StartQuizState createState() => _StartQuizState();
}

class _StartQuizState extends State<StartQuiz> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppNameDisplay(),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        brightness: Brightness.light,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.black87,
        ),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.fromLTRB(24, 50, 24, 0),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(widget.imageUrl),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              //Quiz Title
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // Quiz Description
              Text(
                widget.desc,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // Instructions to follow
              Text(
                '- Each question carries one mark. \n- There is no negative marking. \n- Once selected, an answer cannot be changed. \n- Please attempt all the questions.',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Spacer(),
              //Play quiz button
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlayQuiz(widget.quizId),
                    ),
                  );
                },
                child: blueColorButton(
                    context: context, buttonContent: 'Play Quiz'),
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
