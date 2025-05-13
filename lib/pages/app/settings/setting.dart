import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:zainab_restuarant_app/pages/app/settings/screens/account_setting.dart';
import 'package:zainab_restuarant_app/pages/app/settings/screens/favourite.dart';
import 'package:zainab_restuarant_app/pages/app/settings/screens/help.dart';
import 'package:zainab_restuarant_app/pages/app/settings/screens/notificationsetting.dart';
import 'package:zainab_restuarant_app/pages/app/settings/widgets/account_listtile.dart';
import 'package:zainab_restuarant_app/pages/app/settings/widgets/menu_listtile.dart';
import 'package:zainab_restuarant_app/pages/registration/login.dart';



import 'package:zainab_restuarant_app/utils/constants/sizes.dart';
import 'package:zainab_restuarant_app/utils/popups/loaders.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});
  void _showLogoutDialog(BuildContext context) {
    Get.defaultDialog(
      title: "Logout",
      middleText: "Are you sure you want to logout?",
      textConfirm: "Yes",
      textCancel: "No",
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      cancelTextColor: Colors.black,
      onConfirm: () async {
        await FirebaseAuth.instance.signOut();
        TLoaders.successSnackBar(title: 'Logged Out', message: 'You have been logged out.');
        Get.offAll(() => Login()); // Redirect to login screen
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Settings',style: Theme.of(context).textTheme.headlineMedium,),
              SizedBox(height: TSizes.spaceBtwSections,),
              //acount-listtiles
              account_listtile(),
              SizedBox(height: TSizes.spaceBtwSections,),
              //menu-listtiles
              menu_listtile(icon: Icons.settings, title: 'Account Settings',icon2: Iconsax.arrow_right_34,onpressed: ()=>Get.to(AccountSetting()),),
              menu_listtile(icon: Icons.help, title: 'Help ',icon2:  Iconsax.arrow_right_34,onpressed: ()=>Get.to(Help())),
              menu_listtile(icon: Icons.notifications, title: 'Notification Settings',icon2:  Iconsax.arrow_right_34,onpressed: ()=>Get.to(()=>Notificationsetting())),
              menu_listtile(icon: Icons.favorite, title: 'Favourites ',icon2:  Iconsax.arrow_right_34,onpressed: ()=>Get.to(()=>Favourite()),),
              menu_listtile(icon: Icons.logout, title: 'Logout ',onpressed: ()=> _showLogoutDialog(context),),
            ],
          ),
          
          
          
          
          
          
          
          
          
          ),
        ),
      ),
    );
  }
}

