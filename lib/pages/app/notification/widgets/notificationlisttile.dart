
import 'package:flutter/material.dart';
import 'package:zainab_restuarant_app/utils/constants/image_strings.dart';

class notificationlisttile extends StatelessWidget {
  const notificationlisttile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
          margin: EdgeInsets.only(bottom: 16),
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
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image(image: AssetImage(TImages.user),fit: BoxFit.cover)),
            title: Text("Your order is delievered",style: TextStyle(color: Colors.black),),
            subtitle: Text('10 am',style: TextStyle(color: Colors.black),),
            trailing: IconButton(onPressed: (){}, icon: Icon(Icons.delete,color: Colors.red,)),
          ),
        );
  }
}