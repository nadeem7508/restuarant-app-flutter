import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zainab_restuarant_app/pages/app/home/screens/menu/product_details/product_details.dart';
import 'package:zainab_restuarant_app/pages/app/home/screens/menu/widgets/menu_vertical_items.dart';
import 'package:zainab_restuarant_app/pages/app/home/widgets/grid_layout.dart';
import 'package:zainab_restuarant_app/pages/registration/reset_password/widgets/arrow_header.dart';
import 'package:zainab_restuarant_app/utils/constants/sizes.dart';

class SubmenuScreen extends StatefulWidget {
  final String menuId; // Example: 'pizza'
  final String menuName; // Example: 'Pizza'
  final String submenuName;
  SubmenuScreen({required this.menuId, required this.menuName, required this.submenuName});

  @override
  _SubmenuScreenState createState() => _SubmenuScreenState();
}

class _SubmenuScreenState extends State<SubmenuScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<QueryDocumentSnapshot> submenus = [];

  @override
  void initState() {
    super.initState();
    _fetchSubmenus();
  }

  void _fetchSubmenus() {
    _firestore
        .collection('menus')
        .doc(widget.menuId)
        .collection('submenus')
        .snapshots()
        .listen((snapshot) {
      setState(() {
        submenus = snapshot.docs;
      });
    });
  }

  void _navigateToProduct(String submenuId, String submenuName) async {
  var querySnapshot = await _firestore
      .collection('menus')
      .doc(widget.menuId)
      .collection('submenus')
      .doc(submenuId)
      .collection('products')
      .limit(1) // Fetch only one product
      .get();

  if (querySnapshot.docs.isNotEmpty) {
    var product = querySnapshot.docs.first;
    Get.to(() => ProductDetails(
      productId: product.reference.id, // ✅ Ensure this is the product's document ID
      menuId: widget.menuId, // ✅ Pass the correct menu ID
      submenuId: submenuId, // ✅ Pass the correct submenu ID
      submenuName: submenuName, // ✅ Pass the correct submenu name
    ));
  } else {
    Get.snackbar(
      "No Product",
      "No product available for this submenu",
      snackPosition: SnackPosition.BOTTOM,
    );
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
                        widget.menuName, // Example: 'Pizza'
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: TSizes.spaceBtwItems),
                      submenus.isEmpty
                          ? Center(child: Text("No submenus available"))
                          : grid_layout(
                              itemcount: submenus.length,
                              mainaxisextent: 150,
                              crossaxiscount: 2,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                var submenu = submenus[index];
                                return GestureDetector(
                                  onTap: () {
                                    // Navigate to Product List Screen (Shows only related products)
                                    _navigateToProduct(submenu.id,submenu['name'] ?? 'Unknown');
                                  },
                                  child: menu_vertical_items(
                                    image: submenu['image'],
                                    title: submenu['name'],
                                    index: index,
                                  ),
                                );
                              }),
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
