import 'package:flutter/material.dart';


class arrow_header extends StatelessWidget {
  const arrow_header({
    super.key,  this.onpressed,
  });
final VoidCallback? onpressed;
  @override
  Widget build(BuildContext context) {
    return Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.amber.shade300,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: IconButton(
     onPressed: onpressed,
     icon: Icon(
       Icons.arrow_back_ios,
       size: 25,color:  Color.fromARGB(255, 11, 77, 127),
     ),
     
                ),
              ),
            );
  }
}