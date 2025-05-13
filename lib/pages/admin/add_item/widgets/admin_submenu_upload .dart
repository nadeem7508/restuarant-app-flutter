import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zainab_restuarant_app/pages/app/home/screens/menu/product_details/widgets/cartbtn.dart';
import 'package:zainab_restuarant_app/utils/constants/sizes.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class AdminSubmenuUpload extends StatefulWidget {
  @override
  _AdminSubmenuUploadState createState() => _AdminSubmenuUploadState();
}

class _AdminSubmenuUploadState extends State<AdminSubmenuUpload> {
   final TextEditingController _submenuController = TextEditingController();
  File? _image;
  bool _isLoading = false;
  String? _selectedMenu;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch Menus from Firestore
  Future<List<QueryDocumentSnapshot>> _fetchMenus() async {
    QuerySnapshot snapshot = await _firestore.collection('menus').get();
    return snapshot.docs;
  }

  // Pick Image from Gallery
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Upload Image to ImgBB and Save to Firestore
  Future<void> _uploadSubmenu() async {
    if (_submenuController.text.isEmpty || _image == null || _selectedMenu == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select a menu, enter a name, and choose an image.")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Upload Image to ImgBB
      String apiKey = "da4e4f6cb7ca91f3bd554936e1bda100"; // Replace with your actual ImgBB API key
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://api.imgbb.com/1/upload?key=$apiKey'),
      );

      request.files.add(await http.MultipartFile.fromPath('image', _image!.path));
      var response = await request.send();
      var responseData = await response.stream.bytesToString();
      var jsonResponse = jsonDecode(responseData);

      if (jsonResponse['status'] == 200) {
        String imageUrl = jsonResponse['data']['url'];

        // Save submenu details in Firestore
        await _firestore.collection('menus').doc(_selectedMenu).collection('submenus').add({
          'name': _submenuController.text.trim(),
          'image': imageUrl,
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Submenu added successfully!")));
        _submenuController.clear();
        setState(() {
          _image = null;
        });
      } else {
        throw "ImgBB upload failed: ${jsonResponse['error']['message']}";
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dropdown for selecting menu
            Text(
              'Add Sub Menu',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: FutureBuilder<List<QueryDocumentSnapshot>>(
                future: _fetchMenus(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();
                  List<QueryDocumentSnapshot> menus = snapshot.data!;
                  return DropdownButtonFormField<String>(
                    value: _selectedMenu,
                    hint: Text("Select Menu"),
                    onChanged: (value) {
                      setState(() {
                        _selectedMenu = value;
                      });
                    },
                    items: menus.map((menu) {
                      return DropdownMenuItem<String>(
                        value: menu.id,
                        child: Text(menu['name']),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
            SizedBox(height: TSizes.spaceBtwItems),
        
            Text(
              'Sub-Menu Name',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            SizedBox(height: TSizes.spaceBtwItems),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextFormField(
                controller: _submenuController,
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
            SizedBox(height: 20),
            SizedBox(height: TSizes.spaceBtwSections),
            // Upload Button
            _isLoading
                ? CircularProgressIndicator()
                : cartbtn(onpressed: _uploadSubmenu, title: "Upload Sub Menu"),
          ],
        ),
      ),
    );
  }
}
