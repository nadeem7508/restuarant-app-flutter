import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zainab_restuarant_app/pages/admin/home/screens/reviews.dart';

class ReviewsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('reviews').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoading();
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return _buildNoReviews();
        }

        var reviews = snapshot.data!.docs;
        double totalRating = 0;
        int reviewCount = reviews.length;

        for (var review in reviews) {
          totalRating += (review['rating'] as num).toDouble();
        }

        double avgRating = (reviewCount > 0) ? (totalRating / reviewCount) : 0;

        return _buildReviewSection(avgRating, reviewCount);
      },
    );
  }

  // Loading State
  Widget _buildLoading() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: _boxDecoration(),
      child: Center(child: CircularProgressIndicator()),
    );
  }

  // No Reviews State
  Widget _buildNoReviews() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: _boxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          SizedBox(height: 5),
          Text("No reviews yet", style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  // Main UI with Live Data
  Widget _buildReviewSection(double avgRating, int reviewCount) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: _boxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          SizedBox(height: 5),
          Row(
            children: [
              Icon(Icons.star, color: Colors.amber, size: 24),
              SizedBox(width: 5),
              Text(
                avgRating.toStringAsFixed(1),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              SizedBox(width: 5),
              Text(
                "Total $reviewCount Reviews",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Header with "See All Reviews" Button
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Reviews",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        TextButton(
          onPressed: () => Get.to(() => Reviews()),
          child: Text(
            "See All Reviews",
            style: TextStyle(color: Color.fromARGB(255, 11, 77, 127), fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  // Box Decoration
  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(color: Colors.grey.shade300, blurRadius: 5, spreadRadius: 2),
      ],
    );
  }
}
