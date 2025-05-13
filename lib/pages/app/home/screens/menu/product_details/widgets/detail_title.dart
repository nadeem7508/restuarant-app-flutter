import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zainab_restuarant_app/pages/app/provider/favorites_provider.dart';

class DetailTitle extends StatelessWidget {
  final String title;
  final dynamic submenu;

  const DetailTitle({super.key, required this.title, required this.submenu});

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoritesProvider>(context, listen: true);
    final isFavorite = favoriteProvider.isFavorite(submenu);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .apply(color: Colors.amber),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.location_on, color: Colors.amber),
            ),
            IconButton(
              onPressed: () {
                if (isFavorite) {
                  favoriteProvider.removeListener(submenu);
                } else {
                  favoriteProvider.addListener(submenu);
                }
              },
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
              ),
            )
          ],
        )
      ],
    );
  }
}
