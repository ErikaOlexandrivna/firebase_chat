import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<UserCredential> signInWithEmail({required String email, required String password}) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      print(userCredential);
      return userCredential;
    } on FirebaseAuthException catch (error) {
      throw Exception(error.message);
    }
  }

  Future<UserCredential> signUpWithEmail({required String email, required String password}) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

      _firebaseFirestore.collection('user').doc(userCredential.user!.uid).set({
        'uid' : userCredential.user!.uid,
        'email' : email,
      });

      return (userCredential);
    } on FirebaseAuthException catch (error) {
      print(error.message);
      throw Exception(error.message);
    }
  }
}
