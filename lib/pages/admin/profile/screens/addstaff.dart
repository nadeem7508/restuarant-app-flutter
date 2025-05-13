import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zainab_restuarant_app/pages/app/home/screens/menu/product_details/widgets/cartbtn.dart';
import 'package:zainab_restuarant_app/pages/registration/reset_password/widgets/arrow_header.dart';
import 'package:zainab_restuarant_app/utils/constants/sizes.dart';

class Addstaff extends StatefulWidget {
  const Addstaff({super.key});

  @override
  _AddstaffState createState() => _AddstaffState();
}

class _AddstaffState extends State<Addstaff> {
  final TextEditingController _nameController = TextEditingController();
  File? _image;

  // Pick Image
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Upload Image to ImgBB
  Future<String?> _uploadImageToImgBB(File imageFile) async {
    const String apiKey = "da4e4f6cb7ca91f3bd554936e1bda100"; // Replace with your ImgBB API Key
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://api.imgbb.com/1/upload?key=$apiKey'),
    );
    request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));

    var response = await request.send();
    var responseData = await response.stream.bytesToString();
    var jsonData = json.decode(responseData);

    if (jsonData['success']) {
      return jsonData['data']['url'];
    } else {
      return null;
    }
  }

  // Save Staff Info to Firestore
  Future<void> _uploadStaff() async {
    if (_image == null || _nameController.text.isEmpty) {
      Get.snackbar("Error", "Please enter a name and select an image.");
      return;
    }

    String? imageUrl = await _uploadImageToImgBB(_image!);
    if (imageUrl != null) {
      await FirebaseFirestore.instance.collection('staff').add({
        'name': _nameController.text.trim(),
        'imageUrl': imageUrl,
        'uploadedAt': FieldValue.serverTimestamp(),
      });

      Get.snackbar("Success", "Staff uploaded successfully!");
      setState(() {
        _nameController.clear();
        _image = null;
      });
    } else {
      Get.snackbar("Error", "Image upload failed.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                vertical: 12, horizontal: TSizes.defaultSpace),
            child: arrow_header(
              onpressed: () => Get.back(),
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Add Staff',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: TSizes.spaceBtwItems),

                  // Staff Name
                  Text(
                    'Staff Name',
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  SizedBox(height: TSizes.spaceBtwItems),
                  Container(
                    color: Colors.white,
                    child: TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.grey.shade100),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              BorderSide(color: Color.fromARGB(255, 11, 77, 127), width: 2),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: TSizes.spaceBtwItems),

                  // Image Picker Button
                  _image == null
                      ? OutlinedButton(
                          onPressed: _pickImage, child: Text("Select Image"))
                      : Image.file(_image!, height: 150),

                  SizedBox(height: TSizes.spaceBtwSections),

                  // Upload Staff Button
                  cartbtn(onpressed: _uploadStaff, title: "Upload Staff"),
                ],
              ),
            ),
          ))
        ],
      )),
    );
  }
}
