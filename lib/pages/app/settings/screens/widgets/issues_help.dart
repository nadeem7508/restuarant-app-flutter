import 'package:flutter/material.dart';

class issues_help extends StatelessWidget {
  const issues_help({
    super.key, required this.title,
  });
final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
              Checkbox(value: false, onChanged: (value) {}),
                SizedBox(width: 15,),
              Text(title),
            ]),
        
      ],
    );
  }
}