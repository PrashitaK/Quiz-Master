import 'package:flutter/material.dart';

class AppNameDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 25),
        children: <TextSpan>[
          TextSpan(
              text: 'Quiz',
              style:
                  TextStyle(fontWeight: FontWeight.w500, color: Colors.black)),
          TextSpan(
              text: 'Master',
              style:
                  TextStyle(fontWeight: FontWeight.w500, color: Colors.blue)),
        ],
      ),
    );
  }
}

//this returns a blue button
Widget blueColorButton(
    {BuildContext context, String buttonContent, widthOfButton}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 18),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(30),
    ),
    width: widthOfButton != null
        ? widthOfButton
        : MediaQuery.of(context).size.width,
    child: Text(
      buttonContent,
      style: TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
    ),
  );
}
