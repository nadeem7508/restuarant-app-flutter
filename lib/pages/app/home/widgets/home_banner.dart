import 'package:flutter/material.dart';

class home_banner extends StatelessWidget {
  const home_banner({
    super.key, required this.image1, required this.image2,
  });
final String image1,image2;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(15),
        
        child: Stack(
          children: [
            Image(image: AssetImage(image1)),
            Positioned(
                left: 20,
                top: 8,
                child: Image(
                    image: AssetImage(image2))),
          ],
        ));
  }
}
