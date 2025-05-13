import 'package:flutter/material.dart';
import 'package:zainab_restuarant_app/utils/constants/sizes.dart';


class product_description extends StatelessWidget {
  final String description;
  const product_description({
    super.key, required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(description),
         SizedBox(
      height: TSizes.spaceBtwItems,
    ),

      
      ],
    );
  }
}
