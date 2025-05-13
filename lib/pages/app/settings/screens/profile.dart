import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:zainab_restuarant_app/pages/app/settings/screens/changename.dart';
import 'package:zainab_restuarant_app/pages/app/settings/screens/widgets/TCircularImage%20.dart';
import 'package:zainab_restuarant_app/pages/app/settings/screens/widgets/TMenuitems.dart';
import 'package:zainab_restuarant_app/pages/registration/reset_password/widgets/arrow_header.dart';
import 'package:zainab_restuarant_app/utils/constants/image_strings.dart';
import 'package:zainab_restuarant_app/utils/constants/sizes.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String name = "Loading...";
  String email = "Loading...";
  String profileImageUrl = ""; // Store user's profile picture URL
  File? _image;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      var userDoc = await _firestore.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        setState(() {
          name = userDoc['name'] ?? "No Name";
          email = user.email ?? "No Email";
          profileImageUrl = userDoc['profileImage'] ?? ""; // Fetch profile image
        });
      }
    }
  }

  // Pick Image
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      _uploadImageToImgBB();
    }
  }

  // Upload Image to ImgBB
  Future<void> _uploadImageToImgBB() async {
    if (_image == null) return;

    const String apiKey = "da4e4f6cb7ca91f3bd554936e1bda100"; 
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://api.imgbb.com/1/upload?key=$apiKey'),
    );
    request.files.add(await http.MultipartFile.fromPath('image', _image!.path));

    var response = await request.send();
    var responseData = await response.stream.bytesToString();
    var jsonData = json.decode(responseData);

    if (jsonData['success']) {
      String newProfileUrl = jsonData['data']['url'];
      _updateProfileImage(newProfileUrl);
    } else {
      Get.snackbar("Error", "Image upload failed.");
    }
  }

  // Update Firestore Profile Image
  Future<void> _updateProfileImage(String imageUrl) async {
    User? user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).update({
        'profileImage': imageUrl,
      });

      setState(() {
        profileImageUrl = imageUrl;
      });

      Get.snackbar("Success", "Profile picture updated!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                arrow_header(onpressed: () => Get.back(canPop: true)),
                SizedBox(height: TSizes.spaceBtwItems),

                Text(
                  'Profile',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(height: TSizes.spaceBtwSections),

                // Profile Picture
                Center(
                  child: Column(
                    children: [
                      TCircularImage(
                        image: profileImageUrl.isNotEmpty
                            ? profileImageUrl
                            : TImages.user, // Default placeholder
                        width: 80,
                        height: 80,
                      ),
                      SizedBox(height: TSizes.spaceBtwItems),

                      // Change Profile Button
                      TextButton(
                        onPressed: _pickImage,
                        child: Text('Change Profile Picture'),
                      ),
                    ],
                  ),
                ),

                Divider(),
                SizedBox(height: TSizes.spaceBtwSections),

                // Profile Information
                Text(
                  'Profile Information',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(height: TSizes.spaceBtwItems),

                // Name
                TMenuitems(
                  title: 'Name',
                  value: name,
                  onpressed: () => Get.to(() => Changename()),
                ),

                // Email
                TMenuitems(
                  title: 'Email',
                  value: email,
                  onpressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
