import 'package:flutter/material.dart';
import 'package:quizapp2/widget/widget.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black54,
        ),
        title: AppNameDisplay(),
        brightness: Brightness.light,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            //place widgets below another
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'About                                     ',
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      'Quiz Master is a Mobile Application that allows you to play, create and share quizzes in a simple and intuitive way.',
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      'Quizzes created using quiz master are designed to support self-evaluation and entertainment gaming so that you can create, play and share quizzes that aims to train oneself, train others, memorize knowledge or just enjoy as a quiz game(trivia game) with entertaining content.',
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    Text(
                      'App Version 1.0.0',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Crafted with love by Prashita & Sweta',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
