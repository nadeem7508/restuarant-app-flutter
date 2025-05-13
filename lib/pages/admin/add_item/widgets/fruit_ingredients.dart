import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FruitSelector extends StatelessWidget {
  final RxList<String> fruitselecteditems;
  final List<String> items = ['Apple', 'Banana', 'Grapes', 'Orange', 'Mango'];

  FruitSelector({required this.fruitselecteditems});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Wrap(
          spacing: 10,runSpacing: 8, 
          children: items
              .map((item) => ChoiceChip(
                    label: Text(item),
                    selected: fruitselecteditems.contains(item),backgroundColor: Colors.amber.shade300,
                    selectedColor: Colors.blue, // Highlight selected chip
                    onSelected: (isSelected) {
                      isSelected ? fruitselecteditems.add(item) : fruitselecteditems.remove(item);
                    },
                  ))
              .toList(),
        ));
  }
}

