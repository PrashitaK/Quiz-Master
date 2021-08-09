import 'package:flutter/material.dart';
import 'package:quizapp2/views/about_us.dart';
import 'package:quizapp2/views/contact_us.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Colors.blue.shade800,
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 200,
                    color: Colors.blue.shade800,
                    padding: EdgeInsets.only(top: 30),
                    child: Image(
                      image: AssetImage('images/logo.png'),
                      width: 200,
                      height: 200,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.info_outline,
              color: Colors.black54,
            ),
            title: Text(
              'About Us',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutUs()),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.mail_rounded,
              color: Colors.black54,
            ),
            title: Text(
              'Contact us',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContactUs()),
              );
            },
          ),
          Spacer(),
          Text(
            'Version: 1.0.0',
            style: TextStyle(color: Colors.black38),
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
