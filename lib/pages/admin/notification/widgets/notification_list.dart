
import 'package:flutter/material.dart';
import 'package:zainab_restuarant_app/pages/admin/notification/widgets/notification_tile.dart';
import 'package:zainab_restuarant_app/utils/constants/image_strings.dart';
class NotificationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        NotificationTile("Tanbir Ahmed", "Placed a new order", "20 min ago", TImages.productImage1, TImages.user),
        NotificationTile("Salim Smith", "Left a 5-star review", "20 min ago", TImages.productImage1,TImages.user),
        NotificationTile("Royal Bengal", "Agreed to cancel", "20 min ago", TImages.productImage1, TImages.user),
        NotificationTile("Pabel Vuiya", "Placed a new order", "20 min ago", TImages.productImage1, TImages.user),
      ],
    );
  }
}