import 'package:flutter/material.dart';

class menu_searchbar extends StatefulWidget {
   final String title;
  final Function(String) onSearch; 
  const menu_searchbar({
    super.key, required this.title, required this.onSearch,
  });


  @override
  State<menu_searchbar> createState() => _menu_searchbarState();
}

class _menu_searchbarState extends State<menu_searchbar> {
   TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
    ),
      child: TextField(
         controller: _controller,
           onChanged: widget.onSearch,
                  decoration: InputDecoration(
       
       prefixIcon: Icon(
         Icons.search,
         color:  Color.fromARGB(255, 11, 77, 127),
       ),
       labelText: widget.title,
       border: OutlineInputBorder(
         borderRadius:
             BorderRadius.circular(15), // Circular border
       ),
       enabledBorder: OutlineInputBorder(
         borderRadius: BorderRadius.circular(15),
         borderSide: BorderSide(
             color:
                 Colors.grey.shade100), // Default border color
       ),
       focusedBorder: OutlineInputBorder(
         borderRadius: BorderRadius.circular(15),
         borderSide:
             BorderSide(color:  Color.fromARGB(255, 11, 77, 127), width: 2),
       ),
                  ),
                ),
    );
  }
}