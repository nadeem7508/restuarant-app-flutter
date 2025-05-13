import 'package:flutter/material.dart';

import 'package:zainab_restuarant_app/utils/constants/image_strings.dart';

class VerticalItems extends StatelessWidget {
   final int index;
  const VerticalItems({super.key, required this.index, required image, required title});

  @override
  Widget build(BuildContext context) {
    return Container(
         width: 150,
         child: Container(
           height: 135,
           decoration: BoxDecoration(
             color: Colors.white,
           borderRadius: BorderRadius.circular(15),
         //  border: Border.all(color: Colors.blue.shade300,width: 2),
            boxShadow: [
                   BoxShadow(
          color: Colors.grey.shade300,
          blurRadius: 5,
          spreadRadius: 3,
                   ),
                 ],
           ),
           child: Padding(
             padding:  EdgeInsets.only(top: 20.0),
             child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
             ClipRRect(
             borderRadius: BorderRadius.circular(15),
             child: Image(image: AssetImage(TImages.productImage2),height: 70,width: 120,fit: BoxFit.cover,)),
             SizedBox(height: 10,),
             Text('Russian Salat',style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .apply(color: Colors.black, fontSizeFactor: 1.5),)
              ],
             ),
           ),
         ),
        );
  }
}


