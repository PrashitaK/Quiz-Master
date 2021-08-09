import 'package:flutter/material.dart';

class OptionDisplay extends StatefulWidget {
  final String opt, desc, correctAns, optSelect;

  OptionDisplay({this.desc, this.correctAns, this.opt, this.optSelect});

  @override
  _OptionDisplayState createState() => _OptionDisplayState();
}

class _OptionDisplayState extends State<OptionDisplay> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        // should be visible side by side
        children: [
          Container(
            height: 28,
            width: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                // color of text needs to be changed
                color: widget.optSelect == widget.desc
                    ? widget.desc == widget.correctAns
                        //correct answer
                        ? Colors.green
                        // wrong answer
                        : Colors.red
                    // initially
                    : Colors.grey,
                width: 1.5,
              ),
              // color of circle needs to be changed
              color: widget.optSelect == widget.desc
                  ? widget.desc == widget.correctAns
                      //correct
                      ? Colors.green
                      //wrong
                      : Colors.red
                  //initially
                  : Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            // text of option number (a,b,c,d)
            child: Text(
              widget.opt,
              style: TextStyle(
                color: widget.optSelect == widget.desc
                    //when answered
                    ? Colors.white
                    //initially
                    : Colors.grey,
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          //option text
          Text(
            widget.desc,
            style: TextStyle(
              fontSize: 18,
              color: Colors.black54,
            ),
          )
        ],
      ),
    );
  }
}

class NumOfQuesDisplay extends StatefulWidget {
  final String text;
  final int number;

  NumOfQuesDisplay({this.text, this.number});

  @override
  _NumOfQuesDisplayState createState() => _NumOfQuesDisplayState();
}

class _NumOfQuesDisplayState extends State<NumOfQuesDisplay> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(14),
                    bottomLeft: Radius.circular(14)),
                color: Colors.blue),
            child: Text(
              "${widget.number}",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(14),
                  bottomRight: Radius.circular(14),
                ),
                color: Colors.black54),
            child: Text(
              widget.text,
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
