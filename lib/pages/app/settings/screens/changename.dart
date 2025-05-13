import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zainab_restuarant_app/pages/app/settings/screens/profile.dart';
import 'package:zainab_restuarant_app/pages/onboarding/widgets/onboardingbtn.dart';
import 'package:zainab_restuarant_app/pages/registration/reset_password/widgets/arrow_header.dart';
import 'package:zainab_restuarant_app/utils/constants/sizes.dart';
import 'package:zainab_restuarant_app/utils/constants/text_strings.dart';
import 'package:zainab_restuarant_app/utils/popups/loaders.dart';
import 'package:zainab_restuarant_app/utils/validators/validation.dart';

class Changename extends StatefulWidget {
  const Changename({super.key});

  @override
  State<Changename> createState() => _ChangenameState();
}

class _ChangenameState extends State<Changename> {
  final nameController = TextEditingController();
  GlobalKey<FormState> updateUserNameFormkey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> updateUserName() async {
    if (updateUserNameFormkey.currentState!.validate()) {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).update({
          'name': nameController.text.trim(),
        });

        TLoaders.successSnackBar(
          title: 'Success!',
          message: 'Name Changed Successfully',
        );

        Get.off(() => Profile()); // Go back to profile page
      }
    }
  }

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
                arrow_header(
                  onpressed: () => Get.back(canPop: true),
                ),
                SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
                Text(
                  'You can change your name here.',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(
                  height: TSizes.spaceBtwSections,
                ),

                //form
                Form(
                  key: updateUserNameFormkey,

                  //name
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextFormField(
                      controller: nameController,
                      validator: (value) =>
                          TValidator.validateEmptyText("Name", value),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person,
                          color: Color.fromARGB(255, 11, 77, 127),
                        ),
                        labelText: TTexts.name,
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(15), // Circular border
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                              color:
                                  Colors.grey.shade100), // Default border color
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 11, 77, 127),
                              width: 2),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: TSizes.spaceBtwSections,
                ),

                Center(
                    child: onboardingbtn(
                        onpressed: updateUserName,
                        title: "Save")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
