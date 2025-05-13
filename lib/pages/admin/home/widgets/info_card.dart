
import 'package:flutter/material.dart';
class InfoCard extends StatelessWidget {
  final String count;
  final String label;
  final bool isHighlighted;

  InfoCard(this.count, this.label, {this.isHighlighted = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        
        borderRadius: BorderRadius.circular(10),
        border: isHighlighted ? Border.all(color: Colors.blue, width: 2) : null,
         boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 5,
            spreadRadius: 3,
          ),
        ], 
      ),
      child: Column(
        children: [
          Text(
            count,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 5),
          Text(label, style: TextStyle(fontSize: 12,color: Colors.black,)),
        ],
      ),
    );
  }
}