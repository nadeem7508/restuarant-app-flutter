import 'package:flutter/material.dart';
import 'package:zainab_restuarant_app/pages/registration/success_screen/widgets/success_screen.dart';
import 'package:zainab_restuarant_app/utils/constants/colors.dart';
import 'package:zainab_restuarant_app/utils/constants/image_strings.dart';

import 'package:zainab_restuarant_app/utils/constants/text_strings.dart';

class EmailVerify extends StatelessWidget {
  const EmailVerify({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.white,
      body: SingleChildScrollView(
        child: 
            Column(
             
              children: [
                success_screen(
                    image: TImages.successLogo,
                    title: TTexts.confirmEmail,
                    subtitle: TTexts.confirmEmailSubTitle,
                    onpressed: (){} , btntext: TTexts.tContinue,),
              ],
            ),
                
         
 
      ),
    );
  }
}
