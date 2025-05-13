import 'package:flutter/material.dart';

class DesignList extends StatelessWidget {
  final String imageUrl;

  const DesignList({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(child: CircularProgressIndicator());
            },
            errorBuilder: (context, error, stackTrace) =>
                Icon(Icons.error, size: 50, color: Colors.red),
          ),
        ),
      ),
    );
  }
}
