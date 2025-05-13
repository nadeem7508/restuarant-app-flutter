import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zainab_restuarant_app/pages/app/home/screens/reservetable/widgets/tblreserve_form.dart';
import 'package:zainab_restuarant_app/pages/app/home/widgets/home_header.dart';

import 'package:zainab_restuarant_app/pages/registration/reset_password/widgets/arrow_header.dart';

import 'package:zainab_restuarant_app/utils/constants/sizes.dart';


class Reservetable extends StatelessWidget {
  const Reservetable({super.key});

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
                home_header(title: 'Reservation'),
                SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                //form
                tblreserve_form()
              ],
            ),
          ),
        ),
      ),
    );
  }
}


