

import 'package:flutter/material.dart';
import 'package:zainab_restuarant_app/pages/app/home/screens/design/design.dart';
import 'package:zainab_restuarant_app/pages/app/home/screens/jobs/job.dart';
import 'package:zainab_restuarant_app/pages/app/home/screens/menu/menu.dart';
import 'package:zainab_restuarant_app/pages/app/home/screens/reservetable/reservetable.dart';
import 'package:zainab_restuarant_app/pages/app/home/screens/specialoffers/specialoffer.dart';
import 'package:zainab_restuarant_app/pages/app/home/screens/staff/staff.dart';
import 'package:zainab_restuarant_app/utils/constants/image_strings.dart';


class Category {
  final String image;
  final String name;
  final Widget destinationpage;

  Category({
    
    required this.name, required this.image,required this.destinationpage,
  });


}
final List<Category> items= [
Category(image: TImages.banner1, name: 'Menu', destinationpage: Menu()),
  Category(image: TImages.banner2, name: 'Reservations', destinationpage: Reservetable()),
  Category(image: TImages.banner3,name: 'Find Jobs', destinationpage: Job()),
  Category(image: TImages.banner4,name: 'Special Offers', destinationpage: Specialoffer()),
  Category(image: TImages.banner5, name: 'Staff', destinationpage: Staff()),
  Category(image: TImages.banner6, name: 'Interior Design', destinationpage: Design()),
];