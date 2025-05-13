import 'package:flutter/material.dart';



class PopularItemVertical extends StatelessWidget {
 
 final int index;
  const PopularItemVertical({
    super.key, required this.image, required this.title, required this.index,  
  });

final String image;
final String title;


  @override
  Widget build(BuildContext context) {
    return Container(
         width: 150,
         child: Container(
           height: 120,
           decoration: BoxDecoration(
             color: Colors.white,
           borderRadius: BorderRadius.circular(15),                                  

           //border: Border.all(color: Colors.blue.shade300,width: 2)
           ),
           child: Padding(
             padding:  EdgeInsets.only(top: 20.0),
             child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
             ClipRRect(
             borderRadius: BorderRadius.circular(15),
             child: Image(image: AssetImage(image),height: 70,width: 120,fit: BoxFit.cover,)),
             SizedBox(height: 15,),
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

