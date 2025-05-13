import 'package:flutter/material.dart';


class cartbtn extends StatelessWidget {
  const cartbtn({
    super.key, required this.onpressed, required this.title, 
  });
final VoidCallback? onpressed;
final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 55,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextButton(
            onPressed: onpressed,
            child: Text(title,
                style: TextStyle(color: Colors.white))));
  }
}
