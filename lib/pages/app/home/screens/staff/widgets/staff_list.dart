import 'package:flutter/material.dart';

class StaffList extends StatelessWidget {
  final String name;
  final String imageUrl;

  const StaffList({super.key, required this.name, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              imageUrl,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 8),
          Text(name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
