import 'package:flutter/material.dart';




class menu_vertical_items extends StatelessWidget {
 
 final int index;
  const menu_vertical_items({
    super.key, required this.image, required this.title, required this.index,  
  });

final String image;
final String title;


  @override
  Widget build(BuildContext context) {
    return Container(
         width: 150,
         child: Container(
           height: 135,
           decoration: BoxDecoration(
             color: Colors.white,
           borderRadius: BorderRadius.circular(15),
          // border: Border.all(color: Colors.blue.shade300,width: 2),
           boxShadow: [
                   BoxShadow(
          color: Colors.grey.shade300,
          blurRadius: 5,
          spreadRadius: 3,
                   ),
                 ],
           ),
           child: Padding(
             padding:  EdgeInsets.only(top: 20.0),
             child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
             ClipRRect(
             borderRadius: BorderRadius.circular(15),
             child:  Image.network(
                  image,
                  height: 70,
                  width: 120,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.error), // Show error icon if image fails
                ),
              ),
             SizedBox(height: 10,),
             Text(title,style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .apply(color: Colors.black, fontSizeFactor: 1.5),)
              ],
             ),
           ),
         ),
        );
  }
}

