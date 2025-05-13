import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zainab_restuarant_app/pages/App/home/home.dart';
import 'package:zainab_restuarant_app/pages/registration/success_screen/widgets/success_screen.dart';
import 'package:zainab_restuarant_app/utils/constants/colors.dart';
import 'package:zainab_restuarant_app/utils/constants/image_strings.dart';
import 'package:zainab_restuarant_app/utils/constants/text_strings.dart';

class Jobsuccess extends StatelessWidget {
  const Jobsuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.white,
      body: SingleChildScrollView(
        child: success_screen(
          image: TImages.successLogo,
          title: TTexts.congrats,
          subtitle: TTexts.jobsuccess,
          onpressed: () {
           Get.to(()=>Home());
          }, btntext: TTexts.tContinue,
        ),
      ),
    );
  }
}