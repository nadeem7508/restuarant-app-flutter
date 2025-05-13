import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zainab_restuarant_app/pages/app/settings/screens/widgets/issues_help.dart';
import 'package:zainab_restuarant_app/pages/onboarding/widgets/onboardingbtn.dart';
import 'package:zainab_restuarant_app/pages/registration/reset_password/widgets/arrow_header.dart';
import 'package:zainab_restuarant_app/pages/registration/success_screen/help_success.dart';

import 'package:zainab_restuarant_app/utils/constants/sizes.dart';
import 'package:zainab_restuarant_app/utils/constants/text_strings.dart';
import 'package:zainab_restuarant_app/utils/popups/loaders.dart';

class Help extends StatelessWidget {
  const Help({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              arrow_header(onpressed:()=> Get.back(canPop: true),),
              SizedBox(height: TSizes.spaceBtwItems,),
              Text('Help ',style: Theme.of(context).textTheme.headlineMedium,),
             SizedBox(height: TSizes.spaceBtwSections,),
             //issues
             Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.menu,color: Colors.amber,),
                    SizedBox(width: 15,),
                    Text('Select an Issue',style: Theme.of(context).textTheme.headlineSmall,),
                  ],
                ),
                SizedBox(height:TSizes.spaceBtwItems),
                issues_help(title: TTexts.issue1,),
                issues_help(title: TTexts.issue2,),
                issues_help(title: TTexts.issue3,),
                issues_help(title: TTexts.issue4,),
               
        
                SizedBox(height: TSizes.spaceBtwSections,),
                onboardingbtn(onpressed: (){
                   TLoaders.successSnackBar(title: 'Congratulations!',message: 'Help Saved Successfully');
                  Get.to(HelpSuccess());}, title: 'Submit')
              ],
             )
            ],
          ),
          
          
          
          
          
          
          ),
        ),
      ),
    );
  }
}

