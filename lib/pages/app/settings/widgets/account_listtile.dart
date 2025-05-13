import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zainab_restuarant_app/pages/app/settings/screens/profile.dart';
import 'package:zainab_restuarant_app/utils/constants/image_strings.dart';


class account_listtile extends StatefulWidget {
  const account_listtile({super.key});

  @override
  State<account_listtile> createState() => _account_listtileState();
}

class _account_listtileState extends State<account_listtile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  String name = "Loading...";
  String email = "Loading...";
  String profileImageUrl = ""; // Store profile image URL

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        var userDoc = await _firestore.collection('users').doc(user.uid).get();
        if (userDoc.exists && mounted) {
          setState(() {
            name = userDoc['name'] ?? "No Name";
            email = user.email ?? "No Email";
            profileImageUrl = userDoc['profileImage'] ?? ""; // Fetch profile image
          });
        }
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 5,
            spreadRadius: 3,
          ),
        ],
      ),
      child: ListTile(
        leading: ClipOval(
          child: Image.network(
            profileImageUrl.isNotEmpty
                ? profileImageUrl
                : TImages.user, // Default placeholder
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          name,
          style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.black),
        ),
        subtitle: Text(
          email,
          style: Theme.of(context).textTheme.bodySmall!.apply(color: Colors.black),
        ),
        trailing: IconButton(
          onPressed: () => Get.to(() => Profile()), 
          icon: Icon(Icons.edit, color: Color.fromARGB(255, 11, 77, 127))
        ),
      ),
    );
  }
}
