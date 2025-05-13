import 'package:flutter/material.dart';

class OrderDetailListTile extends StatefulWidget {
  final Map<String, dynamic> product;
  final Function(Map<String, dynamic>) onUpdate;
  const OrderDetailListTile({
    super.key, required this.product, required this.onUpdate,
  });

  @override
  State<OrderDetailListTile> createState() => _OrderDetailListTileState();
}

class _OrderDetailListTileState extends State<OrderDetailListTile> {
   int quantity = 1; 

  @override
  void initState() {
    super.initState();
    quantity = widget.product['quantity'] ?? 1;
  }

  void updateQuantity(int change) {
    setState(() {
      quantity = (quantity + change).clamp(1, 100); 
    });

    double price = (widget.product['price'] as num).toDouble();

    widget.onUpdate({
      ...widget.product,
      'quantity': quantity,
      'totalPrice': quantity * price, // ✅ Ensure this updates correctly
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.network(
            widget.product['imageUrl'] ?? '', 
            height: 90,
            width: 50,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(widget.product['name'] ?? 'Unknown Item', style: TextStyle(color: Colors.black)),
        subtitle: Text('RS ${(widget.product['price'] as num) * quantity}', style: TextStyle(color: Colors.black)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: Colors.yellow.shade300,
                borderRadius: BorderRadius.circular(15)
              ),
              child: IconButton(
                onPressed: () => updateQuantity(-1), 
                icon: Icon(Icons.remove), 
                color: Colors.black,
                iconSize: 15
              ),
            ),
            SizedBox(width: 5),
            Text("$quantity", style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.black)),
            SizedBox(width: 5),
            Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(15)
              ),
              child: IconButton(
                onPressed: () => updateQuantity(1), 
                icon: Icon(Icons.add), 
                color: Colors.black,
                iconSize: 15
              ),
            ),
          ],
        ),
      ),
    );
  }
}
