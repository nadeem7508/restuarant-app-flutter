import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zainab_restuarant_app/pages/app/home/screens/jobs/widgets/job_vertical_items.dart';
import 'package:zainab_restuarant_app/pages/app/home/screens/menu/widgets/menu_searchbar.dart';
import 'package:zainab_restuarant_app/pages/app/home/widgets/grid_layout.dart';
import 'package:zainab_restuarant_app/pages/app/home/widgets/home_header.dart';
import 'package:zainab_restuarant_app/pages/registration/reset_password/widgets/arrow_header.dart';
import 'package:zainab_restuarant_app/utils/constants/image_strings.dart';


import 'package:zainab_restuarant_app/utils/constants/sizes.dart';

class Job extends StatefulWidget {
  const Job({super.key});

  @override
  State<Job> createState() => _JobState();
}

class _JobState extends State<Job> {
  List<Map<String, dynamic>> jobs = [];
  List<Map<String, dynamic>> filteredJobs = [];
  @override
  void initState() {
    super.initState();
    _fetchJobs();
  }

  Future<void> _fetchJobs() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('jobs').orderBy('timestamp', descending: true).get();
    setState(() {
      jobs = querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      filteredJobs = jobs;
    });
  }

  void _onSearch(String query) {
    setState(() {
      filteredJobs = jobs.where((item) => item['jobName'].toLowerCase().contains(query.toLowerCase())).toList();
    });
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
                  vertical: 12,
                  horizontal: TSizes.defaultSpace), // Less padding
              
              child: arrow_header(
                onpressed: () => Get.back(canPop: true),
              ),
            ),
            

            //moveable
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(left: TSizes.defaultSpace,
                          bottom: TSizes.defaultSpace,
                          right: TSizes.defaultSpace,
                          top: 4,),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      home_header(title: 'Jobs'),
                      SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      menu_searchbar(
                        title: 'Find Jobs',
                        onSearch: _onSearch,
                      ),
                      SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),
                      //gridview of items

                      grid_layout(
                        itemcount: filteredJobs.length,
                        crossaxiscount: 1,
                        mainaxisextent: 190,
                        itemBuilder: (context, index) => job_vertical_items(
                          image: TImages.jobs,
                          title: filteredJobs[index]['jobName'],
                          index: index,
                        ),
                        scrollDirection: Axis.vertical,
                      )
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
