import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zainab_restuarant_app/pages/registration/Firebase_Services/firebase_constants.dart';
import 'package:zainab_restuarant_app/pages/registration/Firebase_Services/user_model.dart';


class AuthService {
  // Sign Up with Email & Password
  Future<void> signUp(String name, String email, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Store user details in Firestore
      UserModel newUser = UserModel(
        uid: userCredential.user!.uid,
        name: name,
        email: email,
      );
      await firestore.collection("users").doc(newUser.uid).set(newUser.toMap());

      // Send email verification
      await userCredential.user!.sendEmailVerification();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Login with Email & Password
  Future<User?> login(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Check if email is verified
      if (!userCredential.user!.emailVerified) {
        throw Exception("Please verify your email before logging in.");
      }
      return userCredential.user;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Send Password Reset Email
  Future<void> resetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Fetch user data from Firestore
  Future<UserModel?> getUserData(String uid) async {
    DocumentSnapshot doc = await firestore.collection("users").doc(uid).get();
    if (doc.exists) {
      return UserModel.fromMap(doc.data() as Map<String, dynamic>);
    }
    return null;
  }
}
