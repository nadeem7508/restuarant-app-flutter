import 'package:flutter/material.dart';




class cart_listtile extends StatelessWidget {
    final dynamic product;
  final VoidCallback onRemove;
  const cart_listtile({
    super.key,required this.product, required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
         boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 5,
            spreadRadius: 3,
          ),
        ],
      ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child:Image.network(
            product['imageUrl'] ?? '',
            height: 70,
            width: 70,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                Image.asset('assets/images/placeholder.png', height: 70, width: 70),
          ),
        ),
        title: Text( product['name'] ?? 'Unknown Item',style: TextStyle(color: Colors.black),),
        subtitle: Text('RS ${product['price'] ?? 0}',style: TextStyle(color: Colors.black),),
        trailing: IconButton(onPressed: onRemove, icon: Icon(Icons.remove_shopping_cart,color: Colors.red,)),
      ),
    );
  }
}