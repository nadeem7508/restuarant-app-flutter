import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:zainab_restuarant_app/utils/constants/sizes.dart';
import 'package:zainab_restuarant_app/utils/popups/loaders.dart';

import '../../../registration/reset_password/widgets/arrow_header.dart';

class Notificationsetting extends StatefulWidget {
  const Notificationsetting({super.key});

  @override
  State<Notificationsetting> createState() => _NotificationsettingState();
}

class _NotificationsettingState extends State<Notificationsetting> {
  bool isToggled = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               arrow_header(onpressed:()=> Get.back(canPop: true),),
                SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                Text(
                  'Notifications ',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
        
                //notification settings
                Container(
                  margin: EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                       boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 5,
            spreadRadius: 3,
          ),
        ],
                      ),

                  child: ListTile(
                    title: Text(
                      'Conservations Tones',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    subtitle: Text(
                      'Play sound for incoming and outcoming messages',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        setState(() {
                          isToggled = !isToggled; // Toggle the state when clicked
                          TLoaders.successSnackBar(title: 'Congratulations!',message: 'Changes Saved Successfully');
                        });
                      },
                      icon: Icon(
                        isToggled
                            ? Icons.toggle_on
                            : Icons.toggle_off, // Toggle between two icons
                        color: isToggled ? Colors.amber : Color.fromARGB(255, 11, 77, 127),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
