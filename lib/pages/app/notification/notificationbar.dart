import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:zainab_restuarant_app/pages/app/notification/widgets/notificationlisttile.dart';
import 'package:zainab_restuarant_app/pages/registration/reset_password/widgets/arrow_header.dart';


import 'package:zainab_restuarant_app/utils/constants/sizes.dart';

class Notificationbar extends StatelessWidget {
  const Notificationbar({super.key});

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
                      Text(
                        'Notifications',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),
                      notificationlisttile(),
                    
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
