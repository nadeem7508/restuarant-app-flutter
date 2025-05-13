
import 'package:flutter/material.dart';

class NotificationTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;
  final String image2;
  final String image;

  NotificationTile(this.title, this.subtitle, this.time, this.image2, this.image);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage:AssetImage(image),
        ),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(subtitle,style: TextStyle(fontSize: 12, color: Colors.black)),
            Text(time, style: TextStyle(fontSize: 12, color: Colors.black)),
          ],
        ),
        trailing:  CircleAvatar(
          backgroundImage:AssetImage(image2),
        ),
      ),
    );
  }
}
