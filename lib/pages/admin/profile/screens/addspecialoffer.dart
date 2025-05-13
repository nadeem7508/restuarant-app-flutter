import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:zainab_restuarant_app/pages/app/home/screens/menu/product_details/widgets/cartbtn.dart';
import 'package:zainab_restuarant_app/pages/registration/reset_password/widgets/arrow_header.dart';
import 'package:zainab_restuarant_app/utils/constants/sizes.dart';

class AddSpecialOffer extends StatefulWidget {
  const AddSpecialOffer({super.key});

  @override
  _AddSpecialOfferState createState() => _AddSpecialOfferState();
}

class _AddSpecialOfferState extends State<AddSpecialOffer> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _image;
  final ImagePicker _picker = ImagePicker();
  bool _isUploading = false;

  // ImgBB API Key (Replace with your own key)
  final String imgbbApiKey = 'da4e4f6cb7ca91f3bd554936e1bda100';

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<String?> _uploadImageToImgBB(File imageFile) async {
    final url = Uri.parse('https://api.imgbb.com/1/upload?key=$imgbbApiKey');
    var request = http.MultipartRequest('POST', url)
      ..files.add(await http.MultipartFile.fromPath('image', imageFile.path));

    var response = await request.send();
    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      var jsonData = json.decode(responseData);
      return jsonData['data']['url']; // Return the image URL
    }
    return null;
  }

  Future<void> _uploadSpecialOffer() async {
    if (_titleController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _image == null) {
      Get.snackbar("Error", "All fields are required", backgroundColor: Colors.red);
      return;
    }

    setState(() {
      _isUploading = true;
    });

    String? imageUrl = await _uploadImageToImgBB(_image!);

    if (imageUrl != null) {
      await FirebaseFirestore.instance.collection('special_offers').add({
        'title': _titleController.text,
        'description': _descriptionController.text,
        'image': imageUrl,
        'timestamp': FieldValue.serverTimestamp(),
      });

      Get.snackbar("Success", "Special Offer Uploaded!", backgroundColor: Colors.green);
      _titleController.clear();
      _descriptionController.clear();
      setState(() {
        _image = null;
        _isUploading = false;
      });
    } else {
      Get.snackbar("Error", "Failed to upload image", backgroundColor: Colors.red);
      setState(() {
        _isUploading = false;
      });
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
                children: [
                  Text(
                    'Add Special Offers ',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  SizedBox(height: TSizes.spaceBtwSections),

                  // Title Field
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: "Offer Title",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  SizedBox(height: TSizes.spaceBtwItems),

                  // Description Field
                  TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: "Offer Description",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  SizedBox(height: TSizes.spaceBtwItems),

                  // Image Picker
                  OutlinedButton(
                    onPressed: _pickImage,
                    child: Text(_image == null ? "Select Image" : "Change Image"),
                  ),
                  if (_image != null) 
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.file(_image!, height: 150),
                    ),

                  SizedBox(height: TSizes.spaceBtwItems),

                  // Upload Button
                  cartbtn(
                    onpressed: _isUploading ? null : _uploadSpecialOffer,
                    title: _isUploading ? "Uploading..." : "Upload Special Offer",
                  ),
                ],
              ),
            ),
          )),
        ],
      )),
    );
  }
}
