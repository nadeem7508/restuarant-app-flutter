import 'package:flutter/material.dart';
import 'package:zainab_restuarant_app/pages/onboarding/widgets/onboardingbtn.dart';
import 'package:zainab_restuarant_app/utils/constants/sizes.dart';


class success_screen extends StatelessWidget {
  const success_screen({
    super.key, required this.image, required this.title, required this.subtitle, required this.onpressed, required this.btntext, this.account,
  });
final String image,title,subtitle,btntext;
final String? account;
final VoidCallback onpressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(TSizes.defaultSpace),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 170.0),
          child: Column(
            children: [
              Image(
                  height: 200,
                  image: AssetImage(
                    image,
                  )),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              Text(
                title ,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Colors.yellow, // Your desired color
                    ),
              ),
              SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              Text(
                account ?? '', 
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Colors.yellow, // Your desired color
                    ),
              ),
              SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              Text(subtitle,
                  style: Theme.of(context).textTheme.bodyLarge),
              SizedBox(
                height: 100,
              ),
              onboardingbtn(onpressed: onpressed, title: btntext),
            ],
          ),
        ),
      ),
    );
  }
}
