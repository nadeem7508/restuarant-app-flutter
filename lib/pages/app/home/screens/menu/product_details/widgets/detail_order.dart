import 'package:flutter/material.dart';


class detail_order extends StatelessWidget {
  final bool isAvailable;
  const detail_order({
    super.key, required this.isAvailable,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
    
        Icon(Icons.shopping_bag_outlined,color:Colors.green ,),
        SizedBox(width: 5),
         Text(isAvailable ? 'Available' : 'Out of Stock'),
      ],
    );
  }
}