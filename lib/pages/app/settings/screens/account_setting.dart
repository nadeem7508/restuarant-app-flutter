import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zainab_restuarant_app/pages/app/settings/screens/reauthenticate_user.dart';
import 'package:zainab_restuarant_app/pages/app/settings/widgets/menu_listtile.dart';
import 'package:zainab_restuarant_app/pages/registration/reset_password/widgets/arrow_header.dart';

import 'package:zainab_restuarant_app/utils/constants/sizes.dart';

class AccountSetting extends StatelessWidget {
  const AccountSetting({super.key});

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
             Text('Account Settings',style: Theme.of(context).textTheme.headlineMedium,),
             SizedBox(height: TSizes.spaceBtwSections,),
             //listtiles
             menu_listtile(icon: Icons.security, title: 'Security Notifications'),
             menu_listtile(icon: Icons.email, title: 'Email Address '),
             menu_listtile(icon: Icons.location_on, title: 'Change Address'),
             menu_listtile(icon: Icons.verified_outlined, title: 'Two Step-Verification'),
             menu_listtile(icon: Icons.dataset, title: 'Request Account  Information'),
             menu_listtile(icon: Icons.delete, title: 'Delete Account',onpressed:()=>Get.to(()=>ReauthenticateUser()),),
        
            ],
          ),
          
          
          
          
          
          
          
          
          
          
          ),
        ),
      ),
    );
  }
}