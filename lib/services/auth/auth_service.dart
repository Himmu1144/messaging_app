import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // we gotta get the instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // sign in
  Future<UserCredential> signInWithEmailPass(String email, String pass) async {
    try {
      UserCredential userCred =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);
      // saving user info into a seprate doc
      _firestore.collection('Users').doc(userCred.user!.uid).set({
        'uid': userCred.user!.uid,
        'email': email,
      });
      return userCred;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // sign up
  Future<UserCredential> signUpWithEmailPass(String email, String pass) async {
    try {
      UserCredential userCred = await _auth.createUserWithEmailAndPassword(
          email: email, password: pass);

      // saving user info into a seprate doc
      _firestore.collection('Users').doc(userCred.user!.uid).set({
        'uid': userCred.user!.uid,
        'email': email,
      });

      return userCred;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // sign out
  Future<void> signOut() async {
    return _auth.signOut();
  }

  // errors
}
