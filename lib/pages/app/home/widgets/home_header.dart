import 'package:flutter/material.dart';
import 'package:zainab_restuarant_app/pages/app/notification/notificationbar.dart';
import 'package:zainab_restuarant_app/utils/constants/colors.dart';

class home_header extends StatelessWidget {
  const home_header({
    super.key,
    
    required this.title, 
  });
  final String title;
 
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Stack(
          children: [
            IconButton(
                onPressed: (){
                  Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Notificationbar()));
                },
                icon: Icon(
                  Icons.notifications,
                  color: Color.fromARGB(255, 11, 77, 127),
                  size: 30,
                )),
            Positioned(
              right: 0,
              child: Container(
                height: 18,
                width: 18,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.red.shade300,
                ),
                child: Center(
                    child: Text('2',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .apply(color: TColors.white, fontSizeFactor: 0.8))),
              ),
            )
          ],
        )
      ],
    );
  }
}
