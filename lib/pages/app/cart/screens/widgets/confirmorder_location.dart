import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';


class ConfirmorderLocation extends StatelessWidget {
  const ConfirmorderLocation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
            
      ),
      child: Padding(
        padding:  EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Deliver to:',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                TextButton(onPressed: (){}, child: Text('Edit')),
              ],
            ),
            Row(
              children: [
               Icon(Iconsax.location,color: Color.fromARGB(255, 11, 77, 127),),
               SizedBox(width: 5,),
                Expanded(child: Text('4517 Washington Ave. Manchester, Kentucky 39495',style: TextStyle(color: Colors.black),overflow: TextOverflow.ellipsis,maxLines: 3,softWrap: true,))
              ],
            ),
          ],
        ),
      ),
    );
  }
}