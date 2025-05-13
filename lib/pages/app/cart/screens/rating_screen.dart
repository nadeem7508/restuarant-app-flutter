import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:zainab_restuarant_app/bottomnav.dart';
import 'package:zainab_restuarant_app/pages/app/home/screens/menu/product_details/widgets/cartbtn.dart';

import 'package:zainab_restuarant_app/utils/constants/image_strings.dart';
import 'package:zainab_restuarant_app/utils/constants/sizes.dart';
import 'package:zainab_restuarant_app/utils/popups/loaders.dart';

class RatingScreen extends StatefulWidget {
  @override
  _RatingScreenState createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  double rating = 3;
  TextEditingController feedbackController = TextEditingController();

  // Save review to Firestore
  Future<void> saveReview() async {
    if (feedbackController.text.isEmpty) {
      TLoaders.warningSnackBar(
          title: "Feedback Required", message: "Please enter your feedback.");
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('reviews').add({
        'rating': rating,
        'feedback': feedbackController.text,
        'timestamp': FieldValue.serverTimestamp(),
      });

      TLoaders.successSnackBar(
          title: 'Thank You!', message: 'Feedback Submitted Successfully');
      Get.to(() => Bottomnav());
    } catch (e) {
      TLoaders.errorSnackBar(
          title: "Error", message: "Failed to submit review.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // Prevents screen shrinking when keyboard appears
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Restaurant Logo
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.amber,
                      child: Image(image: AssetImage(TImages.Logo)),
                    ),
                    SizedBox(height: TSizes.spaceBtwItems),

                    // Thank You Message
                    Text(
                      "Thank You!\nEnjoy Your Meal",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: TSizes.spaceBtwItems),

                    Text("Please rate our Restaurant",
                        style: TextStyle(color: Colors.grey)),
                    SizedBox(height: TSizes.spaceBtwItems),

                    // Star Rating Bar
                    RatingBar.builder(
                      initialRating: rating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) =>
                          Icon(Icons.star, color: Colors.amber),
                      onRatingUpdate: (newRating) {
                        setState(() {
                          rating = newRating;
                        });
                      },
                    ),
                    SizedBox(height: TSizes.spaceBtwSections),

                    // Feedback Input Field
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextField(
                        controller: feedbackController,
                        decoration: InputDecoration(
                          hintText: "Leave feedback",
                          prefixIcon: Icon(
                            Icons.edit,
                            color: Color.fromARGB(255, 11, 77, 127),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.grey.shade100),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 11, 77, 127),
                                width: 2),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Sticky Submit & Skip Buttons
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: cartbtn(
                      onpressed:saveReview,
                      title: 'Submit',
                    ),
                  ),
                  SizedBox(width: 10),
                  TextButton(
                    onPressed: () {
                      Get.to(() => Bottomnav());
                    },
                    child: Text("Skip",
                        style: TextStyle(
                          color: Color.fromARGB(255, 11, 77, 127),
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
