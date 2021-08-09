import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizapp2/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebase(FirebaseUser user) {
    //Function which accepts firebase user from below to a User so that we can have the userID
    return user != null ? User(userid: user.uid) : null;
  }

  Future signInEmailAndPass(String email, String pass) async {
    try {
      AuthResult authResult =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);
      FirebaseUser firebaseUser = authResult.user;
      return _userFromFirebase(firebaseUser);
    } catch (e) {
      print(e);
    }
  }

  Future signUpEmailAndPass(String email, String pass) async {
    try {
      AuthResult authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      FirebaseUser user = authResult.user;
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
