

import 'package:flutter/material.dart';
import 'package:zainab_restuarant_app/pages/admin/home/widgets/RunningOrdersBottomSheet.dart';
import 'package:zainab_restuarant_app/pages/admin/home/widgets/info_card.dart';
import 'package:zainab_restuarant_app/pages/admin/home/widgets/popular_items_section.dart';
import 'package:zainab_restuarant_app/pages/admin/home/widgets/revenue_chart.dart';
import 'package:zainab_restuarant_app/pages/admin/home/widgets/review_section.dart';

import 'package:zainab_restuarant_app/utils/constants/image_strings.dart';
import 'package:zainab_restuarant_app/utils/constants/sizes.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}
//bottomsheet
final List<Map<String, String>> orders = [
    {
      'category': '#Breakfast',
      'name': 'Chicken Thai Briyani',
      'id': 'ID: 32053',
      'price': '\$60',
    },
    {
      'category': '#Breakfast',
      'name': 'Chicken Bhuna',
      'id': 'ID: 15253',
      'price': '\$30',
    },
    {
      'category': '#Breakfast',
      'name': 'Vegetarian Poutine',
      'id': 'ID: 21200',
      'price': '\$35',
    },
    {
      'category': '#Breakfast',
      'name': 'Turkey Bacon Strips',
      'id': 'ID: 53241',
      'price': '\$45',
    },
    {
      'category': '#Breakfast',
      'name': 'Veggie Burrito',
      'id': 'ID: 58464',
      'price': '\$25',
    },
  ];

  void _openRunningOrdersBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => RunningOrdersBottomSheet(orders: orders),
    );
  }
class _HomeAdminState extends State<HomeAdmin> {
  String selectedLocation = "Jalalpur Jattan Branch";
  List<String> locations = ["Jalalpur Jattan Branch", "France Branch", ];
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      
      body: SafeArea(
        child: Stack(
          children: [ SingleChildScrollView(
            child: Padding(padding: EdgeInsets.all(TSizes.defaultSpace),
            
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text('Location:',style: Theme.of(context).textTheme.headlineSmall!.apply(color: Colors.amber),),
                         SizedBox(height: 0,),
                         DropdownButton<String>(
                    value: selectedLocation,dropdownColor: Colors.blue,
                    icon: Icon(Icons.arrow_drop_down,color: Color.fromARGB(255, 11, 77, 127),),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedLocation = newValue!;
                      });
                    },
                    items: locations.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                      ],
                    ),
          
                    //logo
                    ClipOval(child: Image(image:AssetImage(TImages.Logo),height: 70,),),
                  ],
                ),
          
                SizedBox(height: TSizes.spaceBtwSections,),
                //orders numbers
          
               Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                           onTap: () => _openRunningOrdersBottomSheet(context),
                          child: InfoCard("20", "RUNNING ORDERS",)),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: InfoCard("05", "ORDER REQUEST", ),
                      ),
                    ],
                  ),
                SizedBox(height: TSizes.spaceBtwSections,),
                  //live chart updates
                  RevenueChart(),
                SizedBox(height: TSizes.spaceBtwSections,),
                  //review sections
                  ReviewsSection(),
                   SizedBox(height: TSizes.spaceBtwSections,),
                   //popular items sections
                  PopularItemsSection(),
              ],
            ),
            
            
            
            ),
          ),
       ] ),
      ),
    );
  }
}