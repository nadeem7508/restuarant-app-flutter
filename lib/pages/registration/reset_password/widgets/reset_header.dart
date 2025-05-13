import 'package:flutter/material.dart';
import 'package:zainab_restuarant_app/utils/constants/sizes.dart';


class reset_header extends StatelessWidget {
  const reset_header({
    super.key, required this.title, required this.subtitle,
  });
final String title,subtitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,style: Theme.of(context).textTheme.headlineLarge,),
         SizedBox(height: TSizes.spaceBtwItems,),
          Text(subtitle,style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}