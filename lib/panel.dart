
import 'package:flutter/material.dart';
import 'package:zainab_restuarant_app/pages/admin/admin_bottomnav.dart';
import 'package:zainab_restuarant_app/pages/onboarding/widgets/onboardingbtn.dart';
import 'package:zainab_restuarant_app/pages/registration/signup.dart';
import 'package:zainab_restuarant_app/pages/registration/widgets/header_register.dart';
import 'package:zainab_restuarant_app/utils/constants/colors.dart';
import 'package:zainab_restuarant_app/utils/constants/sizes.dart';

class Panel extends StatelessWidget {
  const Panel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(TSizes.defaultSpace),
            child: Padding(
              padding:  EdgeInsets.only(top: 120.0),
              child: Column(
                children: [
                  //LOGO AND TITLE
                  header_register(
                    title: 'Welcome Here',
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  
                       //buttons
                   Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   onboardingbtn(
                    onpressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Signup()));
                    },
                    title: 'Customer',
                                   ),
                                   onboardingbtn(
                    onpressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => AdminBottomnav()));
                    },
                    title: 'Admin',
                                   ),
                                   
                                 ],
                               ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}