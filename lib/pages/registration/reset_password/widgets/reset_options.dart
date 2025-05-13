import 'package:flutter/material.dart';
import 'package:zainab_restuarant_app/pages/registration/reset_password/email_reset.dart';
import 'package:zainab_restuarant_app/pages/registration/reset_password/phone_reset.dart';

import 'package:zainab_restuarant_app/utils/constants/sizes.dart';

class reset_options extends StatelessWidget {
  const reset_options({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: (){ 
            Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => PhoneReset()));
          },
          child: Container(
            height: 60,
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
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                children: [
                  Icon(Icons.sms,color:  Color.fromARGB(255, 11, 77, 127),size: 25,),
                  SizedBox(width: TSizes.spaceBtwItems,),
                  Column(
                    children: [
                      Text('Via SMS:',style: Theme.of(context).textTheme.bodyLarge!.apply(color: Colors.black),),
                      
                       Text('+92 *** *******:',style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.black),),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
    
        //by email reset
        SizedBox(
      height: TSizes.spaceBtwItems,
    ),
     GestureDetector(
          onTap: (){ 
            Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => EmailReset()));
          },
          child: Container(
            height: 60,
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
            child: Padding(
              padding:  EdgeInsets.only(left: 10.0),
              child: Row(
                children: [
                  Icon(Icons.email,color:  Color.fromARGB(255, 11, 77, 127),size: 25,),
                  SizedBox(width: TSizes.spaceBtwItems,),
                  Column(
                    children: [
                      Text('Via Email:',style: Theme.of(context).textTheme.bodyLarge!.apply(color: Colors.black),),
                      
                       Text('****@gmail.com:',style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.black),),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
