import 'package:flutter/material.dart';
import 'package:zainab_restuarant_app/pages/registration/success_screen/widgets/success_screen.dart';
import 'package:zainab_restuarant_app/utils/constants/colors.dart';
import 'package:zainab_restuarant_app/utils/constants/image_strings.dart';
import 'package:zainab_restuarant_app/utils/constants/sizes.dart';
import 'package:zainab_restuarant_app/utils/constants/text_strings.dart';

class OrderPlacesSuccess extends StatelessWidget {
  const OrderPlacesSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              success_screen(
                  image: TImages.successLogo,
                  title: TTexts.congrats,
                  subtitle: TTexts.orderplaced,
                  onpressed: (){},
                  btntext: TTexts.home),
            ],
          ),
        ),
      ),
    );
  }
}
