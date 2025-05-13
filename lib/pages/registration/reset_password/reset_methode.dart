import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zainab_restuarant_app/pages/registration/login.dart';
import 'package:zainab_restuarant_app/pages/registration/reset_password/widgets/arrow_header.dart';
import 'package:zainab_restuarant_app/pages/registration/reset_password/widgets/reset_header.dart';
import 'package:zainab_restuarant_app/pages/registration/reset_password/widgets/reset_options.dart';

import 'package:zainab_restuarant_app/utils/constants/sizes.dart';
import 'package:zainab_restuarant_app/utils/constants/text_strings.dart';

class ResetMethode extends StatelessWidget {
  const ResetMethode({super.key});

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
                //arrow back
                arrow_header(onpressed:()=> Get.to(()=>Login()),),
        // header-reset
                SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
                reset_header(
                  title: TTexts.forgetPassword,
                  subtitle: TTexts.forgetPasswordSubTitle,
                ),
        //select options
                SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
                reset_options()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

