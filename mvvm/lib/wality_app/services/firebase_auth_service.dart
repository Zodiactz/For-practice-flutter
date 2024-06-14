import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';

class FireBaseAuthService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  

  Future<auth.User?> signUp(
      String email, String password, String username) async {
    try {
      auth.UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      auth.User? user = userCredential.user;

      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'username': username,
          'email': email,
          'password': password,
        });
      }

      return user;
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  Future<auth.User?> signIn(String email, String password) async {
    try {
      auth.UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      auth.User? user = userCredential.user;

      return user;
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  auth.User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  Future<Map<String, dynamic>?> getUserDetails(String uid) async {
    DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
    return doc.exists ? doc.data() as Map<String, dynamic>? : null;
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      print("Error: $e");
    }
  
  }
}
