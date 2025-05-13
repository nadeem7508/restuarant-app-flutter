import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zainab_restuarant_app/pages/app/home/widgets/grid_layout.dart';
import 'package:zainab_restuarant_app/pages/app/home/widgets/home_banner.dart';
import 'package:zainab_restuarant_app/pages/app/home/widgets/home_header.dart';
import 'package:zainab_restuarant_app/pages/registration/reset_password/widgets/arrow_header.dart';
import 'package:zainab_restuarant_app/utils/constants/image_strings.dart';
import 'package:zainab_restuarant_app/utils/constants/sizes.dart';
import 'package:zainab_restuarant_app/pages/app/home/screens/specialoffers/widgets/specialoffer_items.dart';

class Specialoffer extends StatelessWidget {
  const Specialoffer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                arrow_header(onpressed: () => Get.back(canPop: true)),
                SizedBox(height: TSizes.spaceBtwItems),
                home_header(title: 'Special Offers'),
                SizedBox(height: TSizes.spaceBtwSections),
                Text(
                  'Latest Offers',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(height: 5),
                
                // Fetch special offers from Firestore
                StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('special_offers').orderBy('timestamp', descending: true).snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(child: Text("No Special Offers Available"));
                    }
                    return SizedBox(
                      height: 180,
                      child: grid_layout(
                        itemcount: snapshot.data!.docs.length,
                        mainaxisextent: 270,
                        itemBuilder: (context, index) {
                          var offer = snapshot.data!.docs[index];
                          return SpecialOfferItem(
                            title: offer['title'],
                            description: offer['description'],
                            imageUrl: offer['image'],
                          );
                        },
                        crossaxiscount: 1,
                        scrollDirection: Axis.horizontal,
                      ),
                    );
                  },
                ),

                SizedBox(height: TSizes.spaceBtwSections),
                Text('New Login Offers', style: Theme.of(context).textTheme.headlineSmall),
                SizedBox(height: 5),
                home_banner(image1: TImages.promoBanner1, image2: TImages.promoBanner2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
