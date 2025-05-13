import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zainab_restuarant_app/pages/onboarding/widgets/onboardingbtn.dart';
import 'package:zainab_restuarant_app/pages/registration/reset_password/reset_success.dart';

import 'package:zainab_restuarant_app/utils/constants/text_strings.dart';
import 'package:zainab_restuarant_app/utils/popups/loaders.dart';
import 'package:zainab_restuarant_app/utils/validators/validation.dart';

class resetemail_form extends StatefulWidget {
  const resetemail_form({
    super.key,
  });

  @override
  State<resetemail_form> createState() => _resetemail_formState();
}

class _resetemail_formState extends State<resetemail_form> {
    final email = TextEditingController();
     final FirebaseAuth _auth = FirebaseAuth.instance;
    GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();
    // FUNCTION TO SEND RESET EMAIL
  Future<void> _sendResetEmail() async {
    if (!forgetPasswordFormKey.currentState!.validate()) return;

    try {
      await _auth.sendPasswordResetEmail(email: email.text.trim());

      TLoaders.successSnackBar(
        title: 'Success!',
        message: 'Password reset email sent. Check your inbox.',
      );

      Get.to(() => ResetSuccess());
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Error', message: 'Failed to send reset email. Please check your email.');
    }
  }
  @override
  Widget build(BuildContext context) {
    
    return Form(
      key: forgetPasswordFormKey,
      child: Column(
        children: [
          //email enter
          Container(
             decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
            child: TextFormField(
              controller: email,
              validator: TValidator.validateEmail,
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
        
    
          //button
          SizedBox(
            height: 100,
          ),
          onboardingbtn(
            onpressed: _sendResetEmail,
            title: TTexts.tContinue,
          ),
        ],
      ),
    );
  }
}
