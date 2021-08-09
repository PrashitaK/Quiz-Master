import 'package:flutter/material.dart';
import 'package:quizapp2/widget/widget.dart';

class ContactUs extends StatelessWidget {
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
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Contact Us                                 ',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  'Hi User! \nHave any questions, need help or just stuck somewhere, feel free to contact us.',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  'Email: quizmasterapp@gmail.com',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
