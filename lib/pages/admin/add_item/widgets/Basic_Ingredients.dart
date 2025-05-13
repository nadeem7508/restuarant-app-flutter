import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChipSelector extends StatelessWidget {
  final RxList<String> selectedItems;
  final List<String> items = ['Chicken', 'Onion', 'Garlic', 'Peppers', 'Ginger'];

  ChipSelector({required this.selectedItems});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Wrap(
          spacing: 10,runSpacing: 8, 
          children: items
              .map((item) => ChoiceChip(
                    label: Text(item),
                    selected: selectedItems.contains(item),backgroundColor: Colors.amber.shade300,
                    selectedColor: Colors.blue, // Highlight selected chip
                    onSelected: (isSelected) {
                      isSelected ? selectedItems.add(item) : selectedItems.remove(item);
                    },
                  ))
              .toList(),
        ));
  }
}

