import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:zainab_restuarant_app/pages/onboarding/widgets/onboardingbtn.dart';
import 'package:zainab_restuarant_app/pages/registration/reset_password/widgets/arrow_header.dart';
import 'package:zainab_restuarant_app/pages/registration/signup.dart';
import 'package:zainab_restuarant_app/utils/constants/sizes.dart';
import 'package:zainab_restuarant_app/utils/constants/text_strings.dart';
import 'package:zainab_restuarant_app/utils/popups/loaders.dart';
import 'package:zainab_restuarant_app/utils/validators/validation.dart';

class ReauthenticateUser extends StatefulWidget {
  const ReauthenticateUser({super.key});

  @override
  State<ReauthenticateUser> createState() => _ReauthenticateUserState();
}

class _ReauthenticateUserState extends State<ReauthenticateUser> {
  final verifyEmail = TextEditingController();
    final verifyPassword = TextEditingController();
    final hidePassword = true.obs;
    GlobalKey<FormState> reAuthFormkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
     
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             arrow_header(onpressed:()=> Get.back(canPop: true),),
             SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                Text(
                  'Re-Authenticate Profile',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
        
                //form
                //email
          Form(
            key: reAuthFormkey,
            child: Column(
              children: [
                TextFormField(
                  controller: verifyEmail,
                  validator:  TValidator.validateEmail,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email,
                      color:  Color.fromARGB(255, 11, 77, 127),
                    ),
                    labelText: TTexts.email,
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(15), // Circular border
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
                SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          //password
         Obx(
            ()=> TextFormField(
              controller: verifyPassword,
              validator: (value)=> TValidator.validateEmptyText('Password',value),
              obscureText: hidePassword.value,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.password,
                  color:  Color.fromARGB(255, 11, 77, 127),
                ),
                suffixIcon: IconButton(onPressed: ()=>hidePassword.value = !hidePassword.value,
                 icon: Icon(hidePassword.value? Iconsax.eye_slash:Iconsax.eye,color:  Color.fromARGB(255, 11, 77, 127))),
                labelText: TTexts.password,
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(15), // Circular border
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                      color: Colors
                          .grey.shade100), // Default border color
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
          SizedBox(height: TSizes.spaceBtwSections,),
          onboardingbtn(onpressed: (){
            if (reAuthFormkey.currentState!.validate()) {
                      print("Email: ${verifyEmail.text}");
                      print("Password: ${verifyPassword.text}");
                     TLoaders.successSnackBar(title: 'Congratulations!',message: 'Account Deleted Successfully');
                      Get.to(()=>Signup());
                    }
          }, title: 'Continue'),
              ],
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