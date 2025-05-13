
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';



class ProfileSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const ProfileSection({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
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
          leading: Icon(icon, color: Color.fromARGB(255, 11, 77, 127),),
          title: Text(
            title,
            style: TextStyle(fontSize: 18,color: Colors.black),
          ),
          trailing: Icon(Iconsax.arrow_right_34,color: Color.fromARGB(255, 11, 77, 127),),
          onTap: onTap,
        ),
      ),
    );
  }
}