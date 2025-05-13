import 'package:flutter/material.dart';
import 'package:zainab_restuarant_app/pages/app/home/screens/menu/menu_screens/menu2.dart';
import 'package:zainab_restuarant_app/utils/constants/image_strings.dart';

class MenuModel {
  final String image;
  final String name;
  final Widget destinationpage;

  MenuModel({
    
    required this.name, required this.image,required this.destinationpage,
  });


}
final List<MenuModel> menus= [
MenuModel(image: TImages.productImage2, name: 'Sweet Dish', destinationpage: Menu2()),

  
];