import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zainab_restuarant_app/pages/registration/login.dart';
import 'package:zainab_restuarant_app/pages/registration/success_screen/widgets/success_screen.dart';
import 'package:zainab_restuarant_app/utils/constants/colors.dart';
import 'package:zainab_restuarant_app/utils/constants/image_strings.dart';
import 'package:zainab_restuarant_app/utils/constants/sizes.dart';
import 'package:zainab_restuarant_app/utils/constants/text_strings.dart';
import 'package:zainab_restuarant_app/utils/popups/loaders.dart';

class ResetSuccess extends StatelessWidget {
  const ResetSuccess({super.key, });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            success_screen(
              image: TImages.successLogo,
              account: '',
              title: TTexts.congrats,
              subtitle: TTexts.emailsent,
              onpressed: () =>Get.offAll(()=>Login()),
        
               btntext: TTexts.signIn,
            ),
            SizedBox(height: TSizes.spaceBtwItems,),
            TextButton(onPressed: (){
               TLoaders.successSnackBar(title: 'Congratulations!',message: 'Email Resent to You Successfully');
            }, child: Text('Resend Email'))
          ],
        ),
        
      ),
    );
  }
}