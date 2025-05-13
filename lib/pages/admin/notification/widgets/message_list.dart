
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zainab_restuarant_app/pages/app/chat/live_chat.dart';
class MessagesList extends StatelessWidget {
  final List<Map<String, String>> messages = [
    {'sender': 'Royal Parvej', 'message': 'Source awesome!'},
    {'sender': 'Cameron Williamson', 'message': 'ok, just hurry up little bit..'},
    {'sender': 'Ralph Edwards', 'message': 'Thank dude.'},
    {'sender': 'Cody Fisher', 'message': 'How is going...?'},
    {'sender': 'Eleanor Pena', 'message': 'Thanks for the awesome food menu..'},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),                                   

      ),
          child: ListTile(
            leading: CircleAvatar(
              child: Text(messages[index]['sender']![0]),
            ),
            title: Text(messages[index]['sender']!,style: TextStyle(fontSize: 14, color: Colors.black,)),
            subtitle: Text(messages[index]['message']!,style: TextStyle(fontSize: 12, color: Colors.black)),
            onTap: () {
              Get.to(()=>LiveChat());
            },
          ),
        );
      },
    );
  }
}
