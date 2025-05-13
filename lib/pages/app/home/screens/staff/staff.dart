import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:zainab_restuarant_app/pages/app/home/screens/staff/widgets/staff_list.dart';
import 'package:zainab_restuarant_app/pages/app/home/widgets/grid_layout.dart';
import 'package:zainab_restuarant_app/pages/app/home/widgets/home_header.dart';
import 'package:zainab_restuarant_app/pages/registration/reset_password/widgets/arrow_header.dart';
import 'package:zainab_restuarant_app/utils/constants/sizes.dart';

class Staff extends StatelessWidget {
  const Staff({super.key});

  Future<List<Map<String, String>>> _fetchStaff() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('staff').get();
    
    return snapshot.docs
        .map((doc) => {
              'name': doc['name'] as String,
              'imageUrl': doc['imageUrl'] as String,
            })
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: 12, horizontal: TSizes.defaultSpace),
              child: arrow_header(
                onpressed: () => Get.back(canPop: true),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(TSizes.defaultSpace),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      home_header(title: 'Staff Members'),
                      SizedBox(height: TSizes.spaceBtwSections),

                      FutureBuilder<List<Map<String, String>>>(
                        future: _fetchStaff(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
                            return Center(child: Text("No staff found"));
                          }

                          return grid_layout(
                            itemcount: snapshot.data!.length,
                            mainaxisextent: 150,
                            itemBuilder: (context, index) => StaffList(
                              name: snapshot.data![index]['name']!,
                              imageUrl: snapshot.data![index]['imageUrl']!,
                            ),
                            crossaxiscount: 2,
                            scrollDirection: Axis.vertical,
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
