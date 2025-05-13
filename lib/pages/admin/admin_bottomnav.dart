

import 'package:flutter/material.dart';

import 'package:zainab_restuarant_app/pages/admin/add_item/add_items_admin.dart';
import 'package:zainab_restuarant_app/pages/admin/home/home_admin.dart';
import 'package:zainab_restuarant_app/pages/admin/notification/notifications_admin.dart';
import 'package:zainab_restuarant_app/pages/admin/profile/profile_admin.dart';
import 'package:zainab_restuarant_app/pages/admin/setting/setting_admin.dart';


class AdminBottomnav extends StatefulWidget {
  const AdminBottomnav({super.key});

  @override
  State<AdminBottomnav> createState() => _AdminBottomnavState();
}

class _AdminBottomnavState extends State<AdminBottomnav> {
 int _selectedIndex = 0; // To keep track of the current tab

  // List of pages for each tab
  final List<Widget> _pages = [
    HomeAdmin(),
    SettingAdmin(),
    AddItemsAdmin(),
    NotificationsAdmin(),
    ProfileAdmin(),
     
  ];

  // Handler for navigation bar taps
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      
body: _pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: Padding(
        padding:  EdgeInsets.all(20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: BottomNavigationBar(backgroundColor: Colors.white,
            currentIndex: _selectedIndex, // Highlight the selected tab
            onTap: _onItemTapped, // Handle tab taps
            type: BottomNavigationBarType.fixed, // Fixed navigation bar
            selectedItemColor: Colors.amber,
            unselectedItemColor:  Color.fromARGB(255, 11, 77, 127),
            items:  [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.menu),
                label: 'Menu',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_circle),
                label: 'Add Item',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: 'Updates',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
   