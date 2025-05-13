
import 'package:flutter/material.dart';
import 'package:zainab_restuarant_app/pages/admin/setting/widgets/food_list.dart';
import 'package:zainab_restuarant_app/utils/constants/sizes.dart';
class SettingAdmin extends StatelessWidget {
  const SettingAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 4,
      child: Scaffold(
        
        appBar: AppBar(
           automaticallyImplyLeading: false,
          title: Text(
            'My Food List',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          backgroundColor: Colors.amber.shade300,
          bottom: TabBar(
           labelColor:   Color.fromARGB(255, 11, 77, 127),
            tabs: [
               Tab(text: 'All'),
            Tab(text: 'Breakfast'),
            Tab(text: 'Lunch'),
            Tab(text: 'Dinner'),
            ],
          ),
        ),
        body:
            //notications and messages tabs
    
            SafeArea(
          child: Padding(
            padding: EdgeInsets.all(TSizes.defaultSpace),
            child: TabBarView(
              children: [
               // All Tab
          FoodList(category: 'all',),
    
          // Breakfast Tab
          FoodList(category: 'Breakfast',),
    
          // Lunch Tab
          FoodList(category: 'Lunch',),
    
          // Dinner Tab
          FoodList(category: 'Dinner',),
              ],
            ),
          ),
        ),
      ),
    );
  }
}