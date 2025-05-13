import 'package:flutter/material.dart';

class RunningOrdersBottomSheet extends StatelessWidget {
  final List<Map<String, String>> orders;

  const RunningOrdersBottomSheet({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DraggableScrollableSheet(
        initialChildSize: 0.95, // Initial size of the sheet (50% of the screen)
        minChildSize: 0.4, // Minimum size of the sheet (30% of the screen)
        maxChildSize: 0.95, // Maximum size of the sheet (90% of the screen)
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Running Orders',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.white,
                        margin: EdgeInsets.only(bottom: 16),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                orders[index]['category']!,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                orders[index]['name']!,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                orders[index]['id']!,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    orders[index]['price']!,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          // Handle Done button
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.amber,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 8),
                                        ),
                                        child: Text('Done',style: TextStyle(color: Colors.white),),
                                      ),
                                      SizedBox(width: 8),
                                      ElevatedButton(
                                        onPressed: () {
                                          // Handle Cancel button
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 8),
                                        ),
                                        child: Text('Cancel',style: TextStyle(color: Colors.white),),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}