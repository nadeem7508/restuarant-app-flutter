import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zainab_restuarant_app/pages/onboarding/onboarding_controller.dart';
import 'package:zainab_restuarant_app/pages/onboarding/widgets/onboardingbtn.dart';
import 'package:zainab_restuarant_app/pages/onboarding/widgets/onboardingpage.dart';
import 'package:zainab_restuarant_app/utils/constants/colors.dart';
import 'package:zainab_restuarant_app/utils/constants/image_strings.dart';
import 'package:zainab_restuarant_app/utils/constants/sizes.dart';

import 'package:zainab_restuarant_app/utils/constants/text_strings.dart';

class OnboardingPage extends StatelessWidget {
     final OnboardingController controller = Get.put(OnboardingController());
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: TColors.white,
      body: Stack(
        children: [
          PageView(
             controller: controller.pageController,
             onPageChanged: (index) => controller.currentIndex.value = index,
            children: [
              onboardingpage(
                image: TImages.onBoardingImage1,
                title: TTexts.onBoardingTitle1,
                subtitle: TTexts.onBoardingSubTitle1,
              ),
              onboardingpage(
                image: TImages.onBoardingImage2,
                title: TTexts.onBoardingTitle2,
                subtitle: TTexts.onBoardingSubTitle2,
              ),
            ],
          ),
          SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          //button
          Positioned(
            bottom: 20,
            left: MediaQuery.of(context).size.width / 2 - 75,
            child: onboardingbtn(
              onpressed: controller.nextPage,
                
              title: 'Next',
            ),
          ),
        ],
      ),
    );
  }
}
