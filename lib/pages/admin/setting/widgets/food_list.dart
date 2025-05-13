import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FoodList extends StatelessWidget {
  final String category; // 'breakfast', 'lunch', or 'dinner'

  const FoodList({super.key, required this.category});

  Stream<List<Map<String, dynamic>>> _fetchFoodItems() {
    return FirebaseFirestore.instance.collection('menus').snapshots().asyncMap((menuSnapshot) async {
      List<Map<String, dynamic>> foodItems = [];

      for (var menuDoc in menuSnapshot.docs) {
        var submenusSnapshot = await menuDoc.reference.collection('submenus').get();

        for (var submenuDoc in submenusSnapshot.docs) {
          var productsSnapshot = await submenuDoc.reference.collection('products').get();

          for (var productDoc in productsSnapshot.docs) {
            var productData = productDoc.data();

            if (productData[category] == true) {
              foodItems.add({
                'name': productData['name'],
                'price': productData['price'],
                'imageUrl': productData['imageUrl'],
                'description': productData['description'],
              });
            }
          }
        }
      }
      return foodItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _fetchFoodItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error loading food items'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No food items available'));
          }

          List<Map<String, dynamic>> foodItems = snapshot.data!;

          return ListView.builder(
            itemCount: foodItems.length,
            itemBuilder: (context, index) {
              var item = foodItems[index];
              return ListTile(
                leading: Image.network(item['imageUrl'], width: 50, height: 50, fit: BoxFit.cover),
                title: Text(item['name']),
                subtitle: Text(item['description']),
                trailing: Text('\$${item['price']}'),
              );
            },
          );
        },
      ),
    );
  }
}
