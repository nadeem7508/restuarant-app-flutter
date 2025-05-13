
import 'package:flutter/material.dart';

class menu_listtile extends StatelessWidget {
  const menu_listtile({
    super.key, required this.icon, required this.title, this.icon2, this.onpressed,
  });
final IconData icon;
final String title;
final IconData? icon2;
final VoidCallback? onpressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpressed,
      child: Container(
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
          leading: Icon(icon,color:   Color.fromARGB(255, 11, 77, 127)),
          title: Text(title,style: Theme.of(context).textTheme.bodyLarge!.apply(color: Colors.black),),
          trailing: IconButton(onPressed: (){}, icon: Icon(icon2,color:  Color.fromARGB(255, 11, 77, 127),)),
        ),
      ),
    );
  }
}

