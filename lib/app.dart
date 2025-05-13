import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zainab_restuarant_app/bottomnav.dart';
import 'package:zainab_restuarant_app/pages/admin/admin_bottomnav.dart';
import 'package:zainab_restuarant_app/pages/registration/login.dart';


class App extends StatelessWidget {
  const App({super.key});

  Future<Widget> _getInitialScreen() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Login(); // If no user is logged in, go to login page
    }

    // Check Firestore for role (admin/user)
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection("users").doc(user.uid).get();
    if (userDoc.exists && userDoc.get("role") == "user") {
      return const Bottomnav(); // Navigate to user home
    }

    DocumentSnapshot adminDoc =
        await FirebaseFirestore.instance.collection("admins").doc(user.uid).get();
    if (adminDoc.exists) {
      return const AdminBottomnav(); // Navigate to admin home
    }

    return const Login(); // Default to login if no role is found
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Zainab Restaurant',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: FutureBuilder<Widget>(
        future: _getInitialScreen(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else {
            return snapshot.data ?? const Login();
          }
        },
      ),
    );
  }
}