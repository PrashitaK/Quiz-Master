import 'package:flutter/material.dart';
import 'package:quizapp2/helper/constants.dart';
import 'package:quizapp2/services/auth.dart';
import 'package:quizapp2/services/database.dart';
import 'package:quizapp2/views/main_drawer.dart';
import 'package:quizapp2/views/signin.dart';
import 'package:quizapp2/views/start_quiz.dart';
import 'package:quizapp2/widget/widget.dart';
import 'create_quiz.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Stream quizStream;
  DatabaseService databaseService = new DatabaseService();
  final AuthService _authService = AuthService();

  signOut() async {
    await _authService.signOut().then((val) {
      Constants.saveUserLoginSharedPref(userLogin: false);

      Navigator.pushReplacement(
          //send user to signin screen
          context,
          MaterialPageRoute(builder: (context) => SignIn()));
    });
  }

  Widget quizDisplayList() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: StreamBuilder(
        //we need stream so that our work is realtime. If you make changes in
        //the database it automatically reflects in the app.
        stream: quizStream,
        builder: (context, snapshot) {
          return snapshot.data == null
              ? Container()
              : ListView.builder(
                  //get the length of our document
                  itemCount: snapshot.data.documents.length,
                  //get all variables from firestore
                  itemBuilder: (context, index) {
                    return QuizDataTile(
                      count: snapshot.data.documents.length,
                      imgUrl: snapshot.data.documents[index].data['quizImgUrl'],
                      title: snapshot.data.documents[index].data['quizTitle'],
                      desc: snapshot.data.documents[index].data['quizDesc'],
                      quizId: snapshot.data.documents[index].data['quizId'],
                    );
                  });
        },
      ),
    );
  }

  @override
  void initState() {
    databaseService.getQuizData().then((value) {
      setState(() {
        quizStream = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //drawer insert
      drawer: MainDrawer(),
      appBar: AppBar(
        title: AppNameDisplay(),
        centerTitle: true,
        brightness: Brightness.light,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Colors.blue,
        ),
        //Sign Out icon add
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            color: Colors.blue,
            onPressed: () async {
              //ask user for confirmation
              final ConfirmAction action = await _asyncConfirmDialog(context);
              // print("Confirm Action $action");
              action == ConfirmAction.Accept ? signOut() : null;
            },
          )
        ],
      ),
      body: quizDisplayList(),
      //create quiz button add
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreateQuiz()));
        },
      ),
    );
  }
}

class QuizDataTile extends StatelessWidget {
  final String imgUrl;
  final String title;
  final String desc;
  final String quizId;
  final int count;

  QuizDataTile({
    @required this.imgUrl,
    @required this.title,
    @required this.desc,
    @required this.quizId,
    @required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StartQuiz(
              quizId: quizId,
              title: title,
              desc: desc,
              imageUrl: imgUrl,
              count: count,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        height: 150,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            imgUrl,
            width: MediaQuery.of(context).size.width - 48,
            fit: BoxFit.cover, //take up the whole space
          ),
        ),
      ),
    );
  }
}

enum ConfirmAction { Cancel, Accept }
Future<ConfirmAction> _asyncConfirmDialog(BuildContext context) async {
  return showDialog<ConfirmAction>(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Sign Out?'),
        content: const Text('Are you sure you want to sign out?'),
        actions: <Widget>[
          FlatButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.Cancel);
            },
          ),
          FlatButton(
            child: const Text('Sign Out'),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.Accept);
            },
          )
        ],
      );
    },
  );
}
