import 'package:flutter/material.dart';


import 'pages/App/cart/cart.dart';
import 'pages/App/chat/chat.dart';
import 'pages/App/home/home.dart';
import 'pages/App/settings/setting.dart';

class Bottomnav extends StatefulWidget {
  const Bottomnav({super.key});

  @override
  State<Bottomnav> createState() => _BottomnavState();
}

class _BottomnavState extends State<Bottomnav> {
  int _selectedIndex = 0; // To keep track of the current tab

  // List of pages for each tab
  final List<Widget> _pages = [
    Home(),
   
    Cart(),
    Chat(),
     Setting(),
    
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
        padding: const EdgeInsets.all(20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: BottomNavigationBar(backgroundColor: Colors.white,
            currentIndex: _selectedIndex, // Highlight the selected tab
            onTap: _onItemTapped, // Handle tab taps
            type: BottomNavigationBarType.fixed, // Fixed navigation bar
            selectedItemColor:  Colors.amber,
            unselectedItemColor:  Color.fromARGB(255, 11, 77, 127),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.message),
                label: 'Chat',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Setting',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
   