import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/const.dart';
import 'package:firebase_chat/models/user_model.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<UserCredential> signInWithEmail(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      UserModel userModel =
          UserModel(uid: userCredential.user!.uid, email: email);

      await _firebaseFirestore.collection('users').doc(userModel.uid).set(
            userModel.toMap(),
            SetOptions(merge: true),
          );

      return userCredential;
    } on FirebaseAuthException catch (error) {
      throw Exception(error.message);
    }
  }

  Future<UserCredential> signUpWithEmail(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      UserModel userModel = UserModel(
        uid: userCredential.user!.uid,
        email: email,
      );

      await _firebaseFirestore.collection('users').doc(userModel.uid).set(
            userModel.toMap(),
          );

      return userCredential;
    } on FirebaseAuthException catch (error) {
      print(error.message);
      throw Exception(error.message);
    }
  }
}
