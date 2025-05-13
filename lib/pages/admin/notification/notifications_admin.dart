import 'package:flutter/material.dart';
import 'package:zainab_restuarant_app/pages/admin/notification/widgets/message_list.dart';
import 'package:zainab_restuarant_app/pages/admin/notification/widgets/notification_list.dart';
import 'package:zainab_restuarant_app/utils/constants/sizes.dart';

class NotificationsAdmin extends StatelessWidget {
  const NotificationsAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        
        appBar: AppBar(
        automaticallyImplyLeading: false,
          title: Text(
            'Updates',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          backgroundColor: Colors.amber.shade300,
          bottom: TabBar(
            labelColor:  Color.fromARGB(255, 11, 77, 127),
            tabs: [
              Tab(text: "Notifications"),
              Tab(text: "Messages (3)"),
            ],
          ),
        ),
        body:
            //notications and messages tabs
    
            SafeArea(
          child: Padding(
            padding: EdgeInsets.all(TSizes.defaultSpace),
            child: TabBarView(
              children: [
                NotificationList(),
                MessagesList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
