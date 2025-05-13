import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zainab_restuarant_app/pages/app/home/screens/jobs/widgets/jobapplyform.dart';

import 'package:zainab_restuarant_app/pages/registration/reset_password/widgets/arrow_header.dart';


import 'package:zainab_restuarant_app/utils/constants/sizes.dart';


class JobApply extends StatelessWidget {
  const JobApply({super.key});

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
                arrow_header(onpressed:()=> Get.back(canPop: true),),
                SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                Text(
                  'Upload CV',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
                //form
        
                jobapplyform(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
