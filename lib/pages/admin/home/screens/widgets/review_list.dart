import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zainab_restuarant_app/utils/constants/image_strings.dart';

class ReviewList extends StatelessWidget {
  // Function to build rating stars
  Widget buildRatingStars(int rating) {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: 20,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('reviews').orderBy('timestamp', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No reviews yet."));
          }

          var reviews = snapshot.data!.docs;

          return ListView.builder(
            padding: EdgeInsets.all(16.0),
            itemCount: reviews.length,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              var review = reviews[index].data() as Map<String, dynamic>;

              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(color: Colors.grey.shade300, blurRadius: 5, spreadRadius: 3),
                  ],
                ),
                child: Card(
                  margin: EdgeInsets.only(bottom: 12.0),
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(TImages.user, width: 60, height: 60, fit: BoxFit.cover),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                review['timestamp'] != null
                                    ? DateTime.fromMillisecondsSinceEpoch(review['timestamp'].millisecondsSinceEpoch).toString().split(' ')[0]
                                    : 'Unknown Date',
                                style: TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                              SizedBox(height: 8),
                              buildRatingStars(review['rating']),
                              SizedBox(height: 8),
                              Text(
                                review['feedback'],
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
