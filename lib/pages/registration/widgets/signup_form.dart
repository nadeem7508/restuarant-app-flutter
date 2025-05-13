import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:zainab_restuarant_app/pages/onboarding/widgets/onboardingbtn.dart';
import 'package:zainab_restuarant_app/pages/registration/login.dart';
import 'package:zainab_restuarant_app/utils/constants/sizes.dart';
import 'package:zainab_restuarant_app/utils/constants/text_strings.dart';
import 'package:zainab_restuarant_app/utils/popups/loaders.dart';
import 'package:zainab_restuarant_app/utils/validators/validation.dart';

class signup_form extends StatefulWidget {
  const signup_form({
    super.key,
  });

  @override
  State<signup_form> createState() => _signup_formState();
}

class _signup_formState extends State<signup_form> {
  final name = TextEditingController();
    final email = TextEditingController();
    final password = TextEditingController();
    final hidepassword = true.obs;
    final sendemail = true.obs;
    GlobalKey<FormState> signupformKey = GlobalKey<FormState>();
     final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

   //  SIGNUP FUNCTION
  Future<void> _signup() async {
    if (!signupformKey.currentState!.validate()) return;
 // Show loading dialog
  Get.dialog(
    Center(child: CircularProgressIndicator()),
    barrierDismissible: false, // Prevent user from closing it manually
  );
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      User? user = userCredential.user;
      if (user != null) {
        await user.sendEmailVerification();

        //  SAVE USER DATA TO FIRESTORE
        await _firestore.collection("users").doc(user.uid).set({
          "name": name.text.trim(),
          "email": email.text.trim(),
          "uid": user.uid,
          "createdAt": FieldValue.serverTimestamp(),
        });

        TLoaders.successSnackBar(
          title: 'Verify Your Email!',
          message: 'A verification link has been sent to your email. Please verify before logging in.',
        );

        Get.off(() => Login());
      }
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Signup Failed', message: e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    
    return Form(
        key: signupformKey,
        child: Column(
          children: [
            //NAME
            Container(
               decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
              child: TextFormField(
                controller: name,
                validator: (value) => TValidator.validateEmptyText("Name", value),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.person,
                    color:  Color.fromARGB(255, 11, 77, 127),
                  ),
                  labelText: TTexts.name,
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
                  obscureText: hidepassword.value,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.password,
                      color:  Color.fromARGB(255, 11, 77, 127),
                    ),
                    suffixIcon: IconButton(
                        onPressed: () => hidepassword.value = !hidepassword.value,
                        icon: Icon(
                          hidepassword.value ? Iconsax.eye_slash : Iconsax.eye,
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
            //EMAIL-OPTIONS
            Row(children: [
              Obx(() => Checkbox(
                  value: sendemail.value,
                  checkColor: Colors.blue,
                   fillColor: WidgetStateProperty.resolveWith<Color>(
                        (Set<WidgetState> states) {
                      if (states.contains(WidgetState.selected)) {
                        return Colors.amber; // ✅ Color when checkbox is checked
                      }
                      return Colors.white; // ✅ Default color when unchecked
                    }),
                  onChanged: (value) {
                    sendemail.value = !sendemail.value;
                  })),
              Text(TTexts.sendemail),
            ]),

            SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            //BUTTON
            onboardingbtn(
              onpressed: _signup,
              title: TTexts.createAccount,
            ),
            SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Login()));
                },
                child: Text(TTexts.alreadyaccount))
          ],
        ));
  }
}
