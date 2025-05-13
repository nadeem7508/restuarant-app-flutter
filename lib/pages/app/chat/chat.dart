import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zainab_restuarant_app/pages/app/chat/live_chat.dart';
import 'package:zainab_restuarant_app/pages/app/home/widgets/home_header.dart';

import 'package:zainab_restuarant_app/utils/constants/image_strings.dart';
import 'package:zainab_restuarant_app/utils/constants/sizes.dart';

class Chat extends StatelessWidget {
  const Chat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              home_header(title: "Chat"),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              //members holder
              GestureDetector(
                onTap: () => Get.to(() => LiveChat()),
                child: Container(
                  height: 80,
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
                  child: Center(
                    child: ListTile(
                      leading: Image(image: AssetImage(TImages.user)),
                      title: Text(
                        'Nadeem Muzaffar',
                        style: TextStyle(color: Colors.black),
                      ),
                      subtitle: Text('You can freely Chat!',
                          style: TextStyle(color: Colors.black)),
                      trailing:
                          Text('20:00', style: TextStyle(color: Colors.black)),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
