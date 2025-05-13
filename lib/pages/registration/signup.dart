import 'package:flutter/material.dart';
import 'package:zainab_restuarant_app/common/styles/spacing_styles.dart';

import 'package:zainab_restuarant_app/pages/registration/widgets/header_register.dart';
import 'package:zainab_restuarant_app/pages/registration/widgets/signup_form.dart';

import 'package:zainab_restuarant_app/utils/constants/sizes.dart';
import 'package:zainab_restuarant_app/utils/constants/text_strings.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(
        child: SingleChildScrollView(
            child: Padding(
                padding: TSpacingStyle.paddingWithAppbarHeight,
                child: Column(
                  children: [
                    //header of signup page
                    header_register(title: TTexts.signupTitle),
        SizedBox(height: TSizes.spaceBtwSections,),
                    //form for user data
                    signup_form(),
                  ],
                ))),
      ),
    );
  }
}

