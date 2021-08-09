import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizapp2/models/question_model.dart';
import 'package:quizapp2/services/database.dart';
import 'package:quizapp2/widget/widget.dart';
import 'package:quizapp2/playquizWidgets/play_widgets.dart';
import 'results.dart';

class PlayQuiz extends StatefulWidget {
  final String quizId;
  PlayQuiz(this.quizId);

  @override
  _PlayQuizState createState() => _PlayQuizState();
}

int total = 0;
int attempted = 0;
int notAttempted = 0;
int correct = 0;
int incorrect = 0;

class _PlayQuizState extends State<PlayQuiz> {
  QuerySnapshot quesSnaphot;
  DatabaseService databaseService = new DatabaseService();

  bool _loading = true;

  @override
  void initState() {
    databaseService.getQuesData(widget.quizId).then((value) {
      setState(() {
        quesSnaphot = value;
        _loading = false;

        attempted = 0;
        correct = 0;
        incorrect = 0;
        notAttempted = quesSnaphot.documents.length;
        total = quesSnaphot.documents.length;
      });
    });

    super.initState();
  }

  //get question model from data snapshot
  QuestionModel getQuesModel(DocumentSnapshot quesSnapshot) {
    QuestionModel questionModel = new QuestionModel();

    questionModel.ques = quesSnapshot.data["question"];

    /// shuffling the options
    List<String> options = [
      quesSnapshot.data["option1"],
      quesSnapshot.data["option2"],
      quesSnapshot.data["option3"],
      quesSnapshot.data["option4"]
    ];

    options.shuffle();

    questionModel.opt1 = options[0];
    questionModel.opt2 = options[1];
    questionModel.opt3 = options[2];
    questionModel.opt4 = options[3];

    questionModel.correctOpt = quesSnapshot.data["option1"];
    questionModel.answered = false;

    // print(questionModel.correctOpt.toLowerCase());
    return questionModel;
  }

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
      body: _loading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    quesSnaphot.documents == null
                        ? Container(
                            child: Center(
                              child: Text("No Data. \nCreate a quiz!"),
                            ),
                          )
                        : ListView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            itemCount: quesSnaphot.documents.length,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return PlayQuizDisplayTile(
                                quesModel:
                                    getQuesModel(quesSnaphot.documents[index]),
                                index: index,
                              );
                            },
                          )
                  ],
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Results(
                correct: correct,
                incorrect: incorrect,
                total: total,
                notAttempted: notAttempted,
              ),
            ),
          );
        },
      ),
    );
  }
}

class PlayQuizDisplayTile extends StatefulWidget {
  final QuestionModel quesModel;
  final int index;

  PlayQuizDisplayTile({@required this.quesModel, @required this.index});

  @override
  _PlayQuizDisplayTileState createState() => _PlayQuizDisplayTileState();
}

class _PlayQuizDisplayTileState extends State<PlayQuizDisplayTile> {
  String optSelect = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          //display question number and then the question text
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              "Q${widget.index + 1} ${widget.quesModel.ques}",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          GestureDetector(
            onTap: () {
              //question has not been answered yet -> false
              if (!widget.quesModel.answered) {
                //correct
                if (widget.quesModel.opt1 == widget.quesModel.correctOpt) {
                  optSelect = widget.quesModel.opt1;
                  widget.quesModel.answered = true;
                  correct = correct + 1;
                  attempted = attempted + 1;
                  notAttempted = notAttempted - 1;
                  setState(() {});
                }
                //wrong
                else {
                  optSelect = widget.quesModel.opt1;
                  widget.quesModel.answered = true;
                  incorrect = incorrect + 1;
                  attempted = attempted + 1;
                  notAttempted = notAttempted - 1;
                  setState(() {});
                }
              }
            },
            child: OptionDisplay(
              opt: "A",
              desc: "${widget.quesModel.opt1}",
              correctAns: widget.quesModel.correctOpt,
              optSelect: optSelect,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.quesModel.answered) {
                if (widget.quesModel.opt2 == widget.quesModel.correctOpt) {
                  setState(() {
                    optSelect = widget.quesModel.opt2;
                    widget.quesModel.answered = true;
                    correct = correct + 1;
                    attempted = attempted + 1;
                    notAttempted = notAttempted - 1;
                  });
                } else {
                  setState(() {
                    optSelect = widget.quesModel.opt2;
                    widget.quesModel.answered = true;
                    incorrect = incorrect + 1;
                    attempted = attempted + 1;
                    notAttempted = notAttempted - 1;
                  });
                }
              }
            },
            child: OptionDisplay(
              opt: "B",
              desc: "${widget.quesModel.opt2}",
              correctAns: widget.quesModel.correctOpt,
              optSelect: optSelect,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.quesModel.answered) {
                if (widget.quesModel.opt3 == widget.quesModel.correctOpt) {
                  setState(() {
                    optSelect = widget.quesModel.opt3;
                    widget.quesModel.answered = true;
                    correct = correct + 1;
                    attempted = attempted + 1;
                    notAttempted = notAttempted - 1;
                  });
                } else {
                  setState(() {
                    optSelect = widget.quesModel.opt3;
                    widget.quesModel.answered = true;
                    attempted = attempted + 1;
                    incorrect = incorrect + 1;
                    notAttempted = notAttempted - 1;
                  });
                }
              }
            },
            child: OptionDisplay(
              opt: "C",
              desc: "${widget.quesModel.opt3}",
              correctAns: widget.quesModel.correctOpt,
              optSelect: optSelect,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.quesModel.answered) {
                if (widget.quesModel.opt4 == widget.quesModel.correctOpt) {
                  setState(() {
                    optSelect = widget.quesModel.opt4;
                    widget.quesModel.answered = true;
                    attempted = attempted + 1;
                    correct = correct + 1;
                    notAttempted = notAttempted - 1;
                  });
                } else {
                  setState(() {
                    optSelect = widget.quesModel.opt4;
                    widget.quesModel.answered = true;
                    attempted = attempted + 1;
                    incorrect = incorrect + 1;
                    notAttempted = notAttempted - 1;
                  });
                }
              }
            },
            child: OptionDisplay(
              opt: "D",
              desc: "${widget.quesModel.opt4}",
              correctAns: widget.quesModel.correctOpt,
              optSelect: optSelect,
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
