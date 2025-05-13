import 'package:flutter/material.dart';
import 'package:zainab_restuarant_app/common/styles/spacing_styles.dart';

import 'package:zainab_restuarant_app/pages/registration/widgets/header_register.dart';
import 'package:zainab_restuarant_app/pages/registration/widgets/login_form.dart';


import 'package:zainab_restuarant_app/utils/constants/sizes.dart';
import 'package:zainab_restuarant_app/utils/constants/text_strings.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: TSpacingStyle.paddingWithAppbarHeight,
            child: Column(
              children: [
                //LOGO AND TITLE
                header_register(
                  title: TTexts.loginTitle,
                ),
                SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
                //textformfields
        
                login_form()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
