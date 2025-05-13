import 'package:flutter/material.dart';
import 'package:zainab_restuarant_app/pages/onboarding/widgets/onboardingbtn.dart';

import 'package:zainab_restuarant_app/pages/registration/reset_password/reset_success.dart';
import 'package:zainab_restuarant_app/utils/constants/text_strings.dart';
import 'package:zainab_restuarant_app/utils/popups/loaders.dart';

class resetphone_form extends StatelessWidget {
  const resetphone_form({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          //code
          Container(
            decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
            child: TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.code,
                  color:  Color.fromARGB(255, 11, 77, 127),
                ),
                labelText: '4-Digit Code',
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
                  borderSide:
                      BorderSide(color:  Color.fromARGB(255, 11, 77, 127), width: 2),
                ),
              ),
            ),
          ),
          //button
          SizedBox(
            height: 100,
          ),
          onboardingbtn(
            onpressed: () {
               TLoaders.successSnackBar(title: 'Congratulations!',message: '4-PIN Code Sent to You Successfully');
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => ResetSuccess()));
            },
            title: TTexts.tContinue,
          ),
        ],
      ),
    );
  }
}
