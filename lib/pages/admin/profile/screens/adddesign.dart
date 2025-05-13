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

class Adddesign extends StatefulWidget {
  const Adddesign({super.key});

  @override
  _AdddesignState createState() => _AdddesignState();
}

class _AdddesignState extends State<Adddesign> {
  File? _image;
  bool _isUploading = false;

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
    const String apiKey = "da4e4f6cb7ca91f3bd554936e1bda100"; // Replace with your actual ImgBB API Key
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

  // Upload Image URL to Firestore
  Future<void> _uploadDesign() async {
    if (_image == null) {
      Get.snackbar("Error", "Please select an image first.");
      return;
    }

    setState(() {
      _isUploading = true;
    });

    String? imageUrl = await _uploadImageToImgBB(_image!);
    if (imageUrl != null) {
      await FirebaseFirestore.instance.collection('designs').add({
        'imageUrl': imageUrl,
        'uploadedAt': FieldValue.serverTimestamp(),
      });

      Get.snackbar("Success", "Design uploaded successfully!");
      setState(() {
        _image = null;
      });
    } else {
      Get.snackbar("Error", "Image upload failed.");
    }

    setState(() {
      _isUploading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: TSizes.defaultSpace),
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
                        'Add Interior Design',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: TSizes.spaceBtwItems),

                      // Image Picker Button or Preview
                      _image == null
                          ? OutlinedButton(
                              onPressed: _pickImage, 
                              child: Text("Select Image"),
                            )
                          : Column(
                              children: [
                                Image.file(_image!, height: 150),
                                SizedBox(height: TSizes.spaceBtwItems),
                                OutlinedButton(
                                  onPressed: _pickImage, 
                                  child: Text("Change Image"),
                                ),
                              ],
                            ),

                      SizedBox(height: TSizes.spaceBtwSections),

                      // Upload Button
                      cartbtn(
                        onpressed: _isUploading ? null : _uploadDesign, 
                        title: _isUploading ? "Uploading..." : "Upload Design",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
