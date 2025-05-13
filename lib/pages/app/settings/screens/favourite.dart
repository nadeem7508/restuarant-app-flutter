import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:zainab_restuarant_app/pages/app/home/screens/menu/widgets/menu_vertical_items.dart';
import 'package:zainab_restuarant_app/pages/app/home/widgets/grid_layout.dart';
import 'package:zainab_restuarant_app/pages/app/home/widgets/home_header.dart';
import 'package:zainab_restuarant_app/pages/app/provider/favorites_provider.dart';
import 'package:zainab_restuarant_app/pages/registration/reset_password/widgets/arrow_header.dart';
import 'package:zainab_restuarant_app/utils/constants/sizes.dart';

class Favourite extends StatelessWidget {
  const Favourite({super.key});

  @override
  Widget build(BuildContext context) {
    var favoriteProvider = Provider.of<FavoritesProvider>(context);
    var favoriteItems = favoriteProvider.favorites;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 12,
                horizontal: TSizes.defaultSpace,
              ),
              child: arrow_header(
                onpressed: () => Get.back(canPop: true),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: TSizes.defaultSpace,
                    bottom: TSizes.defaultSpace,
                    right: TSizes.defaultSpace,
                    top: 4,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      home_header(title: 'Favourites'),
                      SizedBox(height: TSizes.spaceBtwSections),

                      // Show Empty Message If No Favorites
                      if (favoriteItems.isEmpty)
                        Center(
                          child: Text(
                            "No favorites added yet!",
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        )
                      else
                        grid_layout(
                          itemcount: favoriteItems.length,
                          mainaxisextent: 150,
                          crossaxiscount: 2,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return menu_vertical_items(
                              image: favoriteItems[index]['image'],
                              title: favoriteItems[index]['name'],
                              index: index,
                            );
                          },
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
