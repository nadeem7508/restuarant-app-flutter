import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:zainab_restuarant_app/utils/constants/sizes.dart';

class TMenuitems extends StatelessWidget {
  const TMenuitems({
    super.key,
    required this.title,
    required this.value,
    required this.onpressed,
    this.icon = Iconsax.arrow_right_34,
  });
  final String title, value;
  final VoidCallback onpressed;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpressed,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: TSizes.spaceItems ?? 8.0)/1.5,
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              flex: 5,
              child: Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              child: Icon(icon, size: 18,color:  Color.fromARGB(255, 11, 77, 127),),
            ),
          ],
        ),
      ),
    );
  }
}
