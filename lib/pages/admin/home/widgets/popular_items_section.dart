import 'package:flutter/material.dart';
import 'package:zainab_restuarant_app/pages/admin/home/models/home_admin_model.dart';
import 'package:zainab_restuarant_app/pages/admin/home/widgets/popular_item_vertical.dart';
import 'package:zainab_restuarant_app/pages/app/home/widgets/grid_layout.dart';

class PopularItemsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Popular Items This Week",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "See All",
                style: TextStyle(
                    color: Color.fromARGB(255, 11, 77, 127),
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
        SizedBox(height: 10),

        //gridview
        SizedBox(
          height: 180,
          child: grid_layout(
            itemcount: popular.length,
            mainaxisextent: 150,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return PopularItemVertical(
                image: popular[index].image,
                title: popular[index].name,
                index: index,
              );
            },
            crossaxiscount: 1,
          ),
        )
      ],
    );
  }
}
