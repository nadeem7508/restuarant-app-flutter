import 'package:flutter/material.dart';
import 'package:zainab_restuarant_app/pages/app/home/models/home_model.dart';


class home_vertical_items extends StatelessWidget {
  final int index;
  const home_vertical_items({
    super.key, required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
     width: 150,
     child: GestureDetector(
      onTap: (){
         Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => items[index].destinationpage,
          ),
        );
      
      },
       child: Container(
         height: 120,
         decoration: BoxDecoration(
           color: Colors.white,
         borderRadius: BorderRadius.circular(15),
       //  border: Border.all(color: Colors.blue.shade300,width: 2),
          boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 5,
            spreadRadius: 3,
          ),
        ],
         ),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
         Padding(
           padding: const EdgeInsets.symmetric(vertical: 10),
           child: Image(image: AssetImage(items[index].image),height: 80,width: 120,),
         ),
         SizedBox(height: 10,),
         Text(items[index].name,style: Theme.of(context)
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
