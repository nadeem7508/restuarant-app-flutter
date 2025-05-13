import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zainab_restuarant_app/pages/admin/profile/screens/adddesign.dart';
import 'package:zainab_restuarant_app/pages/admin/profile/screens/addstaff.dart';
import 'package:zainab_restuarant_app/pages/admin/profile/widgets/profile_section.dart';
import 'package:zainab_restuarant_app/pages/onboarding/widgets/onboardingbtn.dart';
import 'package:zainab_restuarant_app/pages/registration/login.dart';
import 'package:zainab_restuarant_app/utils/constants/colors.dart';
import 'package:zainab_restuarant_app/utils/constants/sizes.dart';
import 'package:zainab_restuarant_app/utils/popups/loaders.dart';

class ProfileAdmin extends StatelessWidget {
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
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Profile',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              // Available Balance Section
              Container(
                width: double.infinity,
                child: Card(
                  elevation: 4,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          'Available Balance',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '\$500.00',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            TLoaders.successSnackBar(
                                title: 'Congratulations!',
                                message: 'Cash Withdraw Successfully');
                            Get.to(() => ProfileAdmin());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber,
                            padding: EdgeInsets.symmetric(
                                horizontal: 32, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Withdraw',
                            style: TextStyle(
                              fontSize: 16,
                              color: TColors.lightGrey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: TSizes.spaceBtwItems),

              // Personal Info Section
              ProfileSection(
                title: 'Personal Info',
                icon: Icons.person,
                onTap: () {
                  // Handle Personal Info tap
                },
              ),
              SizedBox(height: TSizes.spaceBtwItems),

              // Settings Section
              ProfileSection(
                title: 'Settings',
                icon: Icons.settings,
                onTap: () {
                  // Handle Settings tap
                },
              ),
              SizedBox(height: TSizes.spaceBtwItems),

              // Withdrawal History Section
              ProfileSection(
                title: 'Withdrawal History',
                icon: Icons.history,
                onTap: () {},
              ),
              SizedBox(height: TSizes.spaceBtwItems),
              ProfileSection(
                title: 'Add Interior Design ',
                icon: Icons.image,
                onTap: () =>Get.to(()=>Adddesign()),
              ),
              SizedBox(height: TSizes.spaceBtwItems),
              ProfileSection(
                title: 'Add Staff',
                icon: Icons.person,
                onTap: () =>Get.to(()=>Addstaff()),
              ),
              SizedBox(height: TSizes.spaceBtwItems),

              // Number of Orders Section
           /*   Card(
                elevation: 4,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Number of Orders',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '29K',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: TSizes.spaceBtwItems),

              // User Reviews Section
              Card(
                elevation: 4,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'User Reviews',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Iconsax.arrow_right_34,
                          color: Color.fromARGB(255, 11, 77, 127),
                        ),
                        onPressed: () => Get.to(() => Reviews()),
                      ),
                    ],
                  ),
                ),
              ),*/
              SizedBox(height: TSizes.spaceBtwItems),

              // Log Out Button
              Container(
                  width: double.infinity,
                  child: onboardingbtn(
                      onpressed: ()=> _showLogoutDialog(context),
                      title: 'Logout'))
            ],
          ),
        ),
      ),
    );
  }
}
