import 'package:flutter/material.dart';
import 'package:zainab_restuarant_app/utils/constants/colors.dart';

class SpecialOfferItem extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;

  const SpecialOfferItem({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.yellow.shade100,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              imageUrl,
              height: 180,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            right: 30,
            bottom: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineLarge!.apply(color: TColors.white),
                ),
                Text(
                  description,
                  style: Theme.of(context).textTheme.headlineSmall!.apply(color: TColors.white),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
