import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:zainab_restuarant_app/bottomnav.dart';
import 'package:zainab_restuarant_app/pages/admin/admin_bottomnav.dart';

import 'package:zainab_restuarant_app/pages/onboarding/widgets/onboardingbtn.dart';
import 'package:zainab_restuarant_app/pages/registration/reset_password/reset_methode.dart';
import 'package:zainab_restuarant_app/pages/registration/signup.dart';
import 'package:zainab_restuarant_app/utils/constants/sizes.dart';
import 'package:zainab_restuarant_app/utils/constants/text_strings.dart';
import 'package:zainab_restuarant_app/utils/popups/loaders.dart';
import 'package:zainab_restuarant_app/utils/validators/validation.dart';

class login_form extends StatefulWidget {
  const login_form({
    super.key,
  });

  @override
  State<login_form> createState() => _login_formState();
}

class _login_formState extends State<login_form> {
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginformKey = GlobalKey<FormState>();
   final FirebaseAuth auth = FirebaseAuth.instance;
     //  LOGIN FUNCTION
 Future<void> _login() async {
  if (!loginformKey.currentState!.validate()) return;
 // Show loading dialog
  Get.dialog(
    Center(child: CircularProgressIndicator()),
    barrierDismissible: false, // Prevent user from closing it manually
  );
  try {
    String enteredEmail = email.text.trim();
    String enteredPassword = password.text.trim();

    // Hardcoded admin credentials
    if (enteredEmail == "admin@gmail.com" && enteredPassword == "Admin@123") {
      TLoaders.successSnackBar(
        title: 'Welcome Admin!',
        message: 'Login Successful!',
      );
      Get.off(() => AdminBottomnav()); // Navigate to admin panel
      return;
    }

    // If not admin, check Firestore for regular users
    QuerySnapshot userQuery = await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: enteredEmail)
        .get();

    if (userQuery.docs.isNotEmpty) {
      TLoaders.successSnackBar(
        title: 'Welcome!',
        message: 'Login Successful!',
      );
      Get.off(() => Bottomnav()); // Navigate to user panel
      return;
    }

    TLoaders.errorSnackBar(
      title: 'Login Failed',
      message: 'Invalid credentials.',
    );
  } catch (e) {
    TLoaders.errorSnackBar(title: 'Login Error', message: e.toString());
  }
}

  @override
  Widget build(BuildContext context) {
    return Form(
        key: loginformKey,
        child: Column(
          children: [
            //email
            Container(
               decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
              child: TextFormField(
                controller: email,
                validator: (value) => TValidator.validateEmail(value),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.email,
                    color:  Color.fromARGB(255, 11, 77, 127),
                  ),
                  labelText: TTexts.email,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15), // Circular border
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                        color: Colors.grey.shade100), // Default border color
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color:  Color.fromARGB(255, 11, 77, 127), width: 2),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            //password
            Obx(
              () => Container(
                 decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                child: TextFormField(
                  controller: password,
                  validator: (value) => TValidator.validatePassword(value),
                  obscureText: hidePassword.value,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.password,
                      color:  Color.fromARGB(255, 11, 77, 127),
                    ),
                    suffixIcon: IconButton(
                        onPressed: () => hidePassword.value = !hidePassword.value,
                        icon: Icon(
                          hidePassword.value ? Iconsax.eye_slash : Iconsax.eye,
                          color:  Color.fromARGB(255, 11, 77, 127),
                        )),
                    labelText: TTexts.password,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15), // Circular border
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                          color: Colors.grey.shade100), // Default border color
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color:  Color.fromARGB(255, 11, 77, 127), width: 2),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: TSizes.spaceBtwInputFields / 2,
            ),
            //remember me
            Row(children: [
              Obx(
                () => Checkbox(
                    value: rememberMe.value,
                    checkColor: Colors.blue,
                    fillColor: WidgetStateProperty.resolveWith<Color>(
                        (Set<WidgetState> states) {
                      if (states.contains(WidgetState.selected)) {
                        return Colors.amber; // ✅ Color when checkbox is checked
                      }
                      return Colors.white; // ✅ Default color when unchecked
                    }),
                    onChanged: (value) {
                      rememberMe.value = !rememberMe.value;
                    }),
              ),
              Text(TTexts.rememberMe),
            ]),

            SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            //buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                onboardingbtn(
                  onpressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Signup()));
                  },
                  title: TTexts.signUp,
                ),
                onboardingbtn(
                  onpressed:_login,
                  title: TTexts.signIn,
                ),
              ],
            ),
            SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => ResetMethode()));
                },
                child: Text(TTexts.forgetPassword))
          ],
        ));
  }
}
