import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zainab_restuarant_app/pages/registration/reset_password/widgets/arrow_header.dart';
import 'package:zainab_restuarant_app/utils/constants/image_strings.dart';
import 'package:zainab_restuarant_app/utils/constants/sizes.dart';

class LiveChat extends StatefulWidget {
  const LiveChat({super.key});

  @override
  State<LiveChat> createState() => _LiveChatState();
}

class _LiveChatState extends State<LiveChat> {
  TextEditingController messageController = TextEditingController();

  Future<void> _makePhoneCall() async {
  final Uri phoneUri = Uri(scheme: 'tel', path: '123456789'); // Replace with actual number

  if (await canLaunchUrl(phoneUri)) {
    await launchUrl(phoneUri);
  } else {
    print("Could not launch phone app");
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              arrow_header(
                onpressed: () => Get.back(canPop: true),
              ),
              SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              Text(
                'Chat',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              // Header Section
              Container(
                height: 90,
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
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(color: Colors.black),
                    ),
                    subtitle: Row(
                      children: [
                        Text(
                          '•',
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 7,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Online',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                        onPressed: _makePhoneCall,
                        icon: Icon(
                          Iconsax.call,
                          color: Colors.green,
                        )),
                  ),
                ),
              ),

              // Chat Messages Section
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: ListView(
                    children: [
                      _buildChatBubble("Just to order", false),
                      _buildChatBubble(
                          "Okay, for what level of spiciness?", true),
                      _buildChatBubble("Okay, wait a minute 👍", false),
                      _buildChatBubble("Okay I'm waiting ✨", true),
                    ],
                  ),
                ),
              ),

              // Chat Input Field (Fixed at Bottom)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 8)
                    ],
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: messageController,
                        decoration: InputDecoration(
                          hintText: "Type a message...",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    IconButton(
                      icon: Icon(Icons.send, color:  Color.fromARGB(255, 11, 77, 127),),
                      onPressed: () {
                        print("Message Sent: ${messageController.text}");
                        messageController.clear();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Chat Bubble Widget
  Widget _buildChatBubble(String message, bool isMe) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: isMe ? Colors.yellow.shade700 : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(message,
            style: TextStyle(color: isMe ? Colors.white : Colors.black)),
      ),
    );
  }
}
