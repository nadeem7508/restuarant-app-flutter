import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zainab_restuarant_app/pages/admin/add_item/widgets/Basic_Ingredients.dart';
import 'package:zainab_restuarant_app/pages/admin/add_item/widgets/fruit_ingredients.dart';
import 'package:zainab_restuarant_app/pages/admin/admin_bottomnav.dart';

import 'package:zainab_restuarant_app/pages/onboarding/widgets/onboardingbtn.dart';
import 'package:zainab_restuarant_app/utils/constants/sizes.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class add_item extends StatefulWidget {
  const add_item({
    super.key,
  });

  @override
  State<add_item> createState() => _add_itemState();
}

class _add_itemState extends State<add_item> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final RxBool pickup = false.obs;
  final RxBool delivery = false.obs;
  final RxBool breakfast = false.obs;
  final RxBool dinner = true.obs;
  final RxBool launch = false.obs;
  final RxBool instock = false.obs;

  final RxList<String> selectedItems = <String>[].obs;
  final RxList<String> fruitSelectedItems = <String>[].obs;
  String? selectedSubmenu;
  List<String> submenus = [];
  List<String> filteredSubmenus = []; // For search functionality
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchSubmenus();
  }

  Future<void> _fetchSubmenus() async {
    try {
      List<String> fetchedSubmenus = [];

      var menuQuery =
          await FirebaseFirestore.instance.collection('menus').get();

      for (var menuDoc in menuQuery.docs) {
        var submenuQuery = await FirebaseFirestore.instance
            .collection('menus')
            .doc(menuDoc.id)
            .collection('submenus')
            .get();

        for (var submenuDoc in submenuQuery.docs) {
          print("✅ Found submenu: ${submenuDoc['name']}"); // Debugging
          fetchedSubmenus.add(submenuDoc['name'] as String);
        }
      }

      if (fetchedSubmenus.isEmpty) {
        print("⚠️ No submenus found in any menu.");
      }

      setState(() {
        submenus = fetchedSubmenus;
        filteredSubmenus = List.from(submenus);
      });

      print("✅ Final submenu list: $submenus");
    } catch (e) {
      print('❌ Error fetching submenus: $e');
    }
  }

  void _filterSubmenus(String query) {
    setState(() {
      filteredSubmenus = submenus
          .where(
              (submenu) => submenu.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
    print("Filtered Submenus: $filteredSubmenus"); // Debugging
  }

  File? _image;
  final ImagePicker _picker = ImagePicker();

  /// Select Image from Gallery
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  /// Upload Image to ImgBB
  Future<String?> _uploadImage(File imageFile) async {
    try {
      String apiKey = 'da4e4f6cb7ca91f3bd554936e1bda100';
      var request = http.MultipartRequest(
          'POST', Uri.parse('https://api.imgbb.com/1/upload?key=$apiKey'));

      request.files
          .add(await http.MultipartFile.fromPath('image', imageFile.path));

      var response = await request.send();
      var responseData = await response.stream.bytesToString();
      var jsonData = jsonDecode(responseData);

      if (jsonData['status'] == 200) {
        return jsonData['data']['url'];
      } else {
        print('ImgBB upload error: ${jsonData['error']['message']}');
        return null;
      }
    } catch (e) {
      print('Image upload error: $e');
      return null;
    }
  }

  /// Save Data to Firestore under a specific submenu
 Future<void> _saveItem() async {
  if (nameController.text.isEmpty ||
      priceController.text.isEmpty ||
      _image == null ||
      selectedSubmenu == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Please fill all fields and upload an image')),
    );
    return;
  }

  try {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );

    String? imageUrl = await _uploadImage(_image!);
    Navigator.pop(context);

    if (imageUrl == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image upload failed')),
      );
      return;
    }

    // Find submenu document ID and its parent menu ID
    var menuQuery = await FirebaseFirestore.instance.collection('menus').get();
    String? menuId;
    String? submenuId;

    for (var menuDoc in menuQuery.docs) {
      var submenuQuery = await menuDoc.reference.collection('submenus').get();
      for (var submenuDoc in submenuQuery.docs) {
        if (submenuDoc['name'] == selectedSubmenu) {
          menuId = menuDoc.id;
          submenuId = submenuDoc.id;
          break;
        }
      }
      if (submenuId != null) break;
    }

    if (menuId == null || submenuId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Submenu not found')),
      );
      return;
    }

    // Save product in submenu's subcollection
    await FirebaseFirestore.instance
        .collection('menus')
        .doc(menuId)
        .collection('submenus')
        .doc(submenuId)
        .collection('products')
        .add({
      'name': nameController.text,
      'price': double.parse(priceController.text),
      'imageUrl': imageUrl,
      'description': descriptionController.text,
      'pickup': pickup.value,
      'delivery': delivery.value,
      'breakfast': breakfast.value,
      'launch': launch.value,
      'dinner': dinner.value,
      'inStock': instock.value,
      'basicIngredients': selectedItems.toList(),
      'fruitIngredients': fruitSelectedItems.toList(),
      'timestamp': FieldValue.serverTimestamp(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Product added successfully')),
    );

    Get.offAll(() => AdminBottomnav());
  } catch (e) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to save product')),
    );
    print('Firestore error: $e');
  }
}


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Add New Item',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              TextButton(
                  onPressed: () {
                    () {
                      nameController.clear();
                      priceController.clear();
                      descriptionController.clear();
                      setState(() {
                        _image = null;
                      });
                      pickup.value = false;
                      delivery.value = false;
                      breakfast.value = false;
                      launch.value = false;
                      dinner.value = true;
                      instock.value = false;
                      selectedItems.clear();
                      fruitSelectedItems.clear();
                    };
                  },
                  child: Text(
                    'Reset',
                    style: TextStyle(
                        color: Color.fromARGB(255, 11, 77, 127), fontSize: 14),
                  ))
            ],
          ),
          SizedBox(height: TSizes.spaceBtwSections),
          // Search Bar for Submenu
           Text(
            'Search Sub-Menu',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          SizedBox(height: TSizes.spaceBtwItems,),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextFormField(
              controller: _searchController,
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
          SizedBox(
            height: 15,
          ),
          // Display filtered submenus in a ListView
          // Submenu List
          if (filteredSubmenus.isNotEmpty)
            Container(
              height: 200, // Ensures list appears
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              child: ListView.builder(
                itemCount: filteredSubmenus.length,
                itemBuilder: (context, index) {
                  final submenu = filteredSubmenus[index];
                  return ListTile(
                    title: Text(submenu),
                    onTap: () {
                      setState(() {
                        selectedSubmenu = submenu;
                        _searchController.text = submenu; // Update search bar
                        filteredSubmenus = []; // Hide list after selection
                      });
                    },
                  );
                },
              ),
            ),
            SizedBox(height: TSizes.spaceBtwItems,),
          // ITEM NAME
          Text(
            'Item Name',
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
              controller: nameController,
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

          // UPLOAD PHOTO/VIDEO
          Text(
            'UPLOAD PHOTO',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          SizedBox(height: TSizes.spaceBtwItems),
          GestureDetector(
            onTap: _pickImage,
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: _image == null
                    ? Icon(Icons.cloud_upload, size: 50, color: Colors.blue)
                    : Image.file(_image!, fit: BoxFit.cover),
              ),
            ),
          ),
          SizedBox(height: TSizes.spaceBtwItems),

          // PRICE
          Text(
            'Price',
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
              controller: priceController,
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

          // PICK UP / DELIVERY

          Text(
            'Select',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          SizedBox(height: TSizes.spaceBtwItems),
          Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Obx(
                  () => Checkbox(
                      value: pickup.value,
                      checkColor: Colors.blue,
                      fillColor: WidgetStateProperty.resolveWith<Color>(
                          (Set<WidgetState> states) {
                        if (states.contains(WidgetState.selected)) {
                          return Colors
                              .amber; // ✅ Color when checkbox is checked
                        }
                        return Colors.white; // ✅ Default color when unchecked
                      }),
                      onChanged: (value) {
                        pickup.value = !pickup.value;
                      }),
                ),
                Text('Pick Up'),
                SizedBox(
                  width: TSizes.spaceItems,
                ),
                Spacer(),
                Obx(
                  () => Checkbox(
                      value: delivery.value,
                      checkColor: Colors.blue,
                      fillColor: WidgetStateProperty.resolveWith<Color>(
                          (Set<WidgetState> states) {
                        if (states.contains(WidgetState.selected)) {
                          return Colors
                              .amber; // ✅ Color when checkbox is checked
                        }
                        return Colors.white; // ✅ Default color when unchecked
                      }),
                      onChanged: (value) {
                        delivery.value = !delivery.value;
                      }),
                ),
                Text('Delivery'),
              ]),
          SizedBox(height: TSizes.spaceBtwItems),

          //food type --lunch dinner-breakfast
          Text(
            'Select',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          SizedBox(height: TSizes.spaceBtwItems),
          Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Obx(
                  () => Checkbox(
                      value: breakfast.value,
                      checkColor: Colors.blue,
                      fillColor: WidgetStateProperty.resolveWith<Color>(
                          (Set<WidgetState> states) {
                        if (states.contains(WidgetState.selected)) {
                          return Colors
                              .amber; // ✅ Color when checkbox is checked
                        }
                        return Colors.white; // ✅ Default color when unchecked
                      }),
                      onChanged: (value) {
                        breakfast.value = !breakfast.value;
                      }),
                ),
                Text('Breakfast'),
                SizedBox(
                  width: TSizes.spaceItems,
                ),
                Spacer(),
                Obx(
                  () => Checkbox(
                      value: launch.value,
                      checkColor: Colors.blue,
                      fillColor: WidgetStateProperty.resolveWith<Color>(
                          (Set<WidgetState> states) {
                        if (states.contains(WidgetState.selected)) {
                          return Colors
                              .amber; // ✅ Color when checkbox is checked
                        }
                        return Colors.white; // ✅ Default color when unchecked
                      }),
                      onChanged: (value) {
                        launch.value = !launch.value;
                      }),
                ),
                Text('Launch'),
                SizedBox(
                  width: TSizes.spaceItems,
                ),
                Spacer(),
                Obx(
                  () => Checkbox(
                      value: dinner.value,
                      checkColor: Colors.blue,
                      fillColor: WidgetStateProperty.resolveWith<Color>(
                          (Set<WidgetState> states) {
                        if (states.contains(WidgetState.selected)) {
                          return Colors
                              .amber; // ✅ Color when checkbox is checked
                        }
                        return Colors.white; // ✅ Default color when unchecked
                      }),
                      onChanged: (value) {
                        dinner.value = !dinner.value;
                      }),
                ),
                Text('Dinner'),
              ]),

          SizedBox(height: TSizes.spaceBtwItems),

          //in stock or not
          Text(
            'Select',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          SizedBox(height: TSizes.spaceBtwItems),
          Obx(
            () => Checkbox(
                value: instock.value,
                checkColor: Colors.blue,
                fillColor: WidgetStateProperty.resolveWith<Color>(
                    (Set<WidgetState> states) {
                  if (states.contains(WidgetState.selected)) {
                    return Colors.amber; // ✅ Color when checkbox is checked
                  }
                  return Colors.white; // ✅ Default color when unchecked
                }),
                onChanged: (value) {
                  instock.value = !instock.value;
                }),
          ),
          Text('In Stock'),

          SizedBox(
            height: TSizes.spaceBtwSections,
          ),
          Text(
            'Ingredients',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),

          SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          // Basic Ingredients
          Text(
            'Basic',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8),
          ChipSelector(selectedItems: selectedItems), // Chip selection UI

          SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          // Basic Ingredients
          Text(
            'Fruits',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8),
          FruitSelector(
              fruitselecteditems: fruitSelectedItems), // Chip selection UI

          SizedBox(
            height: TSizes.spaceBtwItems,
          ),

          //description of food
          Text(
            'Description',
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
              controller: descriptionController,
              maxLines: null, // Allows the field to expand as needed
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 12, horizontal: 16),
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
          SizedBox(
            height: TSizes.spaceBtwSections,
          ),
          //savebutton

          Container(
              width: double.infinity,
              child: onboardingbtn(onpressed: _saveItem, title: 'Save')),
        ],
      ),
    );
  }
}
