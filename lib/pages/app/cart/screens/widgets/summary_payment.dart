
import 'package:flutter/material.dart';
import 'package:zainab_restuarant_app/utils/constants/colors.dart';
class summary_payment extends StatelessWidget {
  const summary_payment({
    super.key, required this.title, required this.price,
  });
final String title;
final String price;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:  EdgeInsets.only(top: 10.0,left: 15,right: 15,),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,style: TextStyle(color: TColors.white,fontWeight: FontWeight.bold ),),
              Text(price,style: TextStyle(color: TColors.white),),
            ],
          ),
        ),
        
      ],
    );
  }
}
