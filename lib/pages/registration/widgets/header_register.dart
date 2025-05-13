import 'package:flutter/material.dart';
import 'package:zainab_restuarant_app/utils/constants/image_strings.dart';
import 'package:zainab_restuarant_app/utils/constants/sizes.dart';


class header_register extends StatelessWidget {
  const header_register({
    super.key, required this.title,
  });
final String title;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(height: 150, image: AssetImage(TImages.Logo)),
          SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
          )
        ],
      ),
    );
  }
}
