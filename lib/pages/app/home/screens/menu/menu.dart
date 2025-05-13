import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zainab_restuarant_app/pages/app/home/screens/menu/menu_screens/menu1.dart';
import 'package:zainab_restuarant_app/pages/app/home/screens/menu/widgets/menu_searchbar.dart';
import 'package:zainab_restuarant_app/pages/app/home/screens/menu/widgets/menu_vertical_items.dart';
import 'package:zainab_restuarant_app/pages/app/home/widgets/grid_layout.dart';
import 'package:zainab_restuarant_app/pages/app/home/widgets/home_header.dart';

import 'package:zainab_restuarant_app/pages/registration/reset_password/widgets/arrow_header.dart';

import 'package:zainab_restuarant_app/utils/constants/sizes.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<QueryDocumentSnapshot> filteredMenus = []; // Firestore menu list

  @override
  void initState() {
    super.initState();
    _fetchMenus(); // Fetch menus from Firestore
  }

  // Fetch menus from Firestore
  void _fetchMenus() {
    _firestore.collection('menus').snapshots().listen((snapshot) {
      setState(() {
        filteredMenus = snapshot.docs;
      });
    });
  }

  // Function to filter menu items based on search input
  void _onSearch(String query) {
    setState(() {
      filteredMenus = filteredMenus
          .where((item) => item['name']
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
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
            padding: EdgeInsets.symmetric(
                vertical: 12, horizontal: TSizes.defaultSpace), // Less padding

            child: arrow_header(
              onpressed: () => Get.back(canPop: true),
            ),
          ),

          //moveable
          Expanded(
            child: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.only(
                      left: TSizes.defaultSpace,
                      bottom: TSizes.defaultSpace,
                      right: TSizes.defaultSpace,
                      top: 4,
                    ), // Reduce space between header and content),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          home_header(title: 'Menu'),
                          SizedBox(
                            height: TSizes.spaceBtwItems,
                          ),
                          //searchbar
                          menu_searchbar(
                            title: 'What do you want to order?',
                            onSearch: _onSearch,
                          ),
                          SizedBox(
                            height: TSizes.spaceBtwSections,
                          ),

                          //gridview
                          filteredMenus.isEmpty
                              ? Center(child: Text("No menus found"))
                              : grid_layout(
                                  itemcount: filteredMenus.length,
                                  mainaxisextent: 150,
                                  crossaxiscount: 2,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    var menu = filteredMenus[index];
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => SubmenuScreen(
                                              menuId: menu
                                                  .id, // ✅ Pass actual menu ID
                                              menuName:
                                                  menu['name'] ?? 'Unknown',
                                              submenuName: '',
                                            ),
                                          ),
                                        );
                                      },
                                      child: menu_vertical_items(
                                        image: menu['image'],
                                        title: menu['name'],
                                        index: index,
                                      ),
                                    );
                                  }),
                        ]))),
          ),
        ],
      ),
    ));
  }
}
