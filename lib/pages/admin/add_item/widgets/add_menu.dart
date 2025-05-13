import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:zainab_restuarant_app/pages/app/home/screens/menu/product_details/widgets/cartbtn.dart';
import 'package:zainab_restuarant_app/utils/constants/sizes.dart';

class AddMenu extends StatefulWidget {
  @override
  _AddMenuState createState() => _AddMenuState();
}

class _AddMenuState extends State<AddMenu> {
  final TextEditingController _nameController = TextEditingController();
  File? _image;
  bool _isLoading = false;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ImgBB API Key
  final String apiKey =
      "da4e4f6cb7ca91f3bd554936e1bda100"; // Replace with your actual API key

  // Pick Image
  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Upload Image to ImgBB and Save Menu Data
  Future<void> _uploadMenu() async {
    if (_nameController.text.isEmpty || _image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please enter name and select an image")));
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Upload image to ImgBB
      String? imageUrl = await _uploadImageToImgBB(_image!);
      if (imageUrl == null) {
        throw "Image upload failed";
      }

      // Save menu details in Firestore
      await _firestore.collection('menus').add({
        'name': _nameController.text,
        'image': imageUrl,
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Menu added successfully!")));
      _nameController.clear();
      setState(() {
        _image = null;
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: $e")));
    }

    setState(() {
      _isLoading = false;
    });
  }

  // Function to Upload Image to ImgBB
  Future<String?> _uploadImageToImgBB(File imageFile) async {
    try {
      Uri url = Uri.parse("https://api.imgbb.com/1/upload?key=$apiKey");

      var request = http.MultipartRequest("POST", url)
        ..files.add(await http.MultipartFile.fromPath('image', imageFile.path));

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseData = jsonDecode(await response.stream.bytesToString());
        return responseData['data']['url']; // Return uploaded image URL
      } else {
        print("Upload failed: ${response.reasonPhrase}");
        return null;
      }
    } catch (e) {
      print("Error uploading image: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add New Item',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            Text(
              'Menu Name',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15), // Circular border
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                        color: Colors.grey.shade100), // Default border color
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 11, 77, 127), width: 2),
                  ),
                ),
              ),
            ),
            SizedBox(height: TSizes.spaceBtwItems),

            // Image Picker
            _image == null
                ? Text("No image selected")
                : Image.file(_image!, height: 150),
            SizedBox(height: TSizes.spaceBtwItems),
            OutlinedButton(onPressed: _pickImage, child: Text("Select Image")),
            SizedBox(height: TSizes.spaceBtwSections),

            // Upload Button
            _isLoading
                ? CircularProgressIndicator()
                : cartbtn(onpressed: _uploadMenu, title: "Upload Menu"),
          ],
        ),
      ),
    );
  }
}
