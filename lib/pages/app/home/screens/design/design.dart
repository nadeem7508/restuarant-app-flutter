import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:zainab_restuarant_app/pages/app/home/screens/design/widgets/design_list.dart';
import 'package:zainab_restuarant_app/pages/app/home/widgets/grid_layout.dart';
import 'package:zainab_restuarant_app/pages/app/home/widgets/home_header.dart';
import 'package:zainab_restuarant_app/pages/registration/reset_password/widgets/arrow_header.dart';
import 'package:zainab_restuarant_app/utils/constants/sizes.dart';

class Design extends StatelessWidget {
  const Design({super.key});

  Future<List<String>> _fetchDesigns() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('designs').get();
    
    return snapshot.docs
        .map((doc) => doc['imageUrl'] as String)
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
                  padding: EdgeInsets.only(
                    left: TSizes.defaultSpace,
                    bottom: TSizes.defaultSpace,
                    right: TSizes.defaultSpace,
                    top: 4,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      home_header(title: 'Interior Design'),
                      SizedBox(height: TSizes.spaceBtwSections),

                      FutureBuilder<List<String>>(
                        future: _fetchDesigns(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          if (snapshot.hasError) {
                            return Center(child: Text("Error loading images"));
                          }
                          if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return Center(child: Text("No designs found"));
                          }

                          return grid_layout(
                            itemcount: snapshot.data!.length,
                            mainaxisextent: 150,
                            itemBuilder: (context, index) =>
                                DesignList(imageUrl: snapshot.data![index]),
                            crossaxiscount: 1,
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
