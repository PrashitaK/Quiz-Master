import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String userid;

  DatabaseService({this.userid});

  //add user data to firebase database
  Future<void> addUserData(uData) async {
    Firestore.instance.collection("users").add(uData).catchError((e) {
      print(e);
    });
  }

  //get user data from firebase database
  getUserData() async {
    return await Firestore.instance.collection("users").document(userid);
  }

  //add quiz data to firebase database
  Future<void> addQuizData(Map quizData, String quizId) async {
    await Firestore.instance
        .collection("Quiz")
        .document(quizId)
        .setData(quizData)
        .catchError((e) {
      print(e);
    });
  }

  //add question data to firebase databse
  Future<void> addQuesData(Map quesData, String quizId) async {
    await Firestore.instance
        .collection('Quiz')
        .document(quizId)
        .collection(
            'QNA') //create a new collection for our questiona and answer
        .add(quesData) //add the map into it
        .catchError((e) {
      print(e.toString());
    });
  }

  //get quiz data from firebase database
  getQuizData() async {
    return await Firestore.instance.collection("Quiz").snapshots();
  }

  //get question data from firebase database
  getQuesData(String quizId) async {
    return await Firestore.instance
        .collection("Quiz")
        .document(quizId)
        .collection("QNA")
        .getDocuments();
  }
}
