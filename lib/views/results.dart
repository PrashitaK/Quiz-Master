import 'package:flutter/material.dart';
import 'package:quizapp2/widget/widget.dart';

class Results extends StatefulWidget {
  final int total, correct, incorrect, notAttempted;

  Results({
    this.incorrect,
    this.total,
    this.correct,
    this.notAttempted,
  });

  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppNameDisplay(),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        brightness: Brightness.light,
        elevation: 0.0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Score: ${widget.correct}/${widget.total}",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Total questions : ${widget.total}",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "Correct Answers : ${widget.correct}",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "Incorrect Answers : ${widget.incorrect}",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "Questions not attempted : ${widget.notAttempted}",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: 80,
              ),
              // Home button
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: blueColorButton(
                  context: context,
                  buttonContent: 'Go to Home',
                ),
              ),
              SizedBox(
                height: 80,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
