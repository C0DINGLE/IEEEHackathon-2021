import 'package:firebase_auth/firebase_auth.dart';
import './database.dart';

class AuthService {
  
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _userId;

  // auth change user stream
  Stream<User> get user {
    return _auth.authStateChanges();
      //.map((FirebaseUser user) => _userFromFirebaseUser(user));
      // .map(_userFromFirebaseUser);
  }


  // Register User
  Future signUp ({String email, String password, String username, String number, String role}) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      _userId = user.uid;
      // create document under users collection with user data
      await DatabaseService(uid: user.uid).updateUserData(
        username: username,
        email: email,
        number: number,
        password: password,
        role: role,
      );
      return user;

    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // SIGN IN USER
  Future signIn(email, password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      _userId = user.uid;
      return user;
    } catch(e) {
      print(e.toString());
      return null;
    }
  } 

  // SIGN OUT
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
  // void _setUserId(){
  //   userId = _auth.currentUser.uid;
  // }
  
  String getUserId() {
     return _userId;
  }

}