import 'package:flutter/material.dart';
import 'package:zainab_restuarant_app/utils/constants/sizes.dart';


class grid_layout extends StatelessWidget {
  const grid_layout({
    super.key, required this.itemcount, this.mainaxisextent, required this.itemBuilder, required this.crossaxiscount,required this.scrollDirection,
  });
final int crossaxiscount;
final int itemcount;
final double? mainaxisextent;
final Axis scrollDirection;
final Widget Function(BuildContext,int) itemBuilder;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      scrollDirection: scrollDirection,
      physics: ScrollPhysics(),
        itemCount: itemcount,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossaxiscount,
            mainAxisSpacing: TSizes.gridViewSpacing,
            crossAxisSpacing: TSizes.gridViewSpacing,
            mainAxisExtent: mainaxisextent),
        itemBuilder: itemBuilder);
  }
}