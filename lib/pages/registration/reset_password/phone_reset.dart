import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:zainab_restuarant_app/pages/registration/reset_password/widgets/arrow_header.dart';
import 'package:zainab_restuarant_app/pages/registration/reset_password/widgets/reset_header.dart';
import 'package:zainab_restuarant_app/pages/registration/reset_password/widgets/resetphone_form.dart';

import 'package:zainab_restuarant_app/utils/constants/sizes.dart';
import 'package:zainab_restuarant_app/utils/constants/text_strings.dart';

class PhoneReset extends StatelessWidget {
  const PhoneReset({super.key});

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
                  height: TSizes.spaceBtwSections,
                ),
                reset_header(
                    title: TTexts.resetpasswordtitle,
                    subtitle: TTexts.resetpasswordsubtitle1),
                SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
                resetphone_form()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

