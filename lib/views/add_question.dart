import 'package:flutter/material.dart';
import 'package:quizapp2/services/database.dart';
import 'package:quizapp2/widget/widget.dart';

class AddQuestion extends StatefulWidget {
  final String quizId;
  AddQuestion(this.quizId);

  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  DatabaseService databaseService = new DatabaseService();
  final _formKey = GlobalKey<FormState>();

  bool _loading = false;

  String ques = "", opt1 = "", opt2 = "", opt3 = "", opt4 = "";

  uploadQuesData() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _loading = true;
      });

      Map<String, String> quesMap = {
        "question": ques,
        "option1": opt1,
        "option2": opt2,
        "option3": opt3,
        "option4": opt4
      };

      // print("${widget.quizId}");
      await databaseService.addQuesData(quesMap, widget.quizId).then((value) {
        setState(() {
          _loading = false;
        });
      }).catchError((e) {
        print(e);
      });
    } else {
      print("Error occured");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
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
              child: Center(child: CircularProgressIndicator()),
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
                    // Question input
                    TextFormField(
                      validator: (val) => val.isEmpty ? "Enter Question" : null,
                      decoration: InputDecoration(hintText: "Question"),
                      onChanged: (val) {
                        ques = val;
                      },
                      //have a multiline input
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    // Option 1 input -> has to be the correct answer
                    TextFormField(
                      validator: (val) => val.isEmpty ? "Option1 " : null,
                      decoration:
                          InputDecoration(hintText: "Option1 (Correct Answer)"),
                      onChanged: (val) {
                        opt1 = val;
                      },
                      //have a multiline input in description
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    //Option 2 input
                    TextFormField(
                      validator: (val) => val.isEmpty ? "Option2 " : null,
                      decoration: InputDecoration(hintText: "Option2"),
                      onChanged: (val) {
                        opt2 = val;
                      },
                      //have a multiline input in description
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    //Option 3 input
                    TextFormField(
                      validator: (val) => val.isEmpty ? "Option3 " : null,
                      decoration: InputDecoration(hintText: "Option3"),
                      onChanged: (val) {
                        opt3 = val;
                      },
                      //have a multiline input in description
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    //Option 4 input
                    TextFormField(
                      validator: (val) => val.isEmpty ? "Option4 " : null,
                      decoration: InputDecoration(hintText: "Option4"),
                      onChanged: (val) {
                        opt4 = val;
                      },
                      //have a multiline input in description
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                    ),
                    Spacer(),
                    Row(
                      children: [
                        // Submit button
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context); //closes the present window
                          },
                          child: blueColorButton(
                              context: context,
                              buttonContent: 'Submit',
                              widthOfButton:
                                  MediaQuery.of(context).size.width / 2 - 36),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        // Add more questions button
                        GestureDetector(
                          onTap: () {
                            uploadQuesData();
                          },
                          child: blueColorButton(
                              context: context,
                              buttonContent: 'Add Question',
                              widthOfButton:
                                  MediaQuery.of(context).size.width / 2 - 36),
                        ),
                      ],
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
