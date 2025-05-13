import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zainab_restuarant_app/pages/app/home/screens/jobs/job_apply.dart';
import 'package:zainab_restuarant_app/utils/constants/sizes.dart';

class job_vertical_items extends StatelessWidget {
   final int index;
  const job_vertical_items({
    super.key, required this.image, required this.title, required this.index,
  });
final String image;
final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Container(
        height: 180,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            //border: Border.all(color: Colors.blue.shade300),
             boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 5,
            spreadRadius: 3,
          ),
        ],
            ),
        child: Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image(
                    image: AssetImage(
                      image,
                    ),
                    height: 120,
                    width: 280,
                    fit: BoxFit.cover,
                  )),
                  SizedBox(height: 5,),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .apply(color: Colors.black, fontSizeFactor: 1.5),
                    ),
                    Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextButton(onPressed: ()=>Get.to(()=>JobApply()), child: Text('Apply',style: TextStyle(color: Colors.black),))),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
