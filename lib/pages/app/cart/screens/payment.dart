import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zainab_restuarant_app/pages/app/home/screens/menu/product_details/widgets/cartbtn.dart';
import 'package:zainab_restuarant_app/pages/registration/reset_password/widgets/arrow_header.dart';

import 'package:zainab_restuarant_app/utils/constants/image_strings.dart';
import 'package:zainab_restuarant_app/utils/constants/sizes.dart';
import 'package:zainab_restuarant_app/utils/popups/loaders.dart';
import 'package:zainab_restuarant_app/utils/validators/validation.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  // Controllers for text fields
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final TextEditingController postCodeController = TextEditingController();
  String selectedCountry = "Pakistan";
  GlobalKey<FormState> paymentformkey = GlobalKey<FormState>();
  @override
  void dispose() {
    // Dispose controllers to free up memory
    cardNumberController.dispose();
    expDateController.dispose();
    cvvController.dispose();
    postCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                vertical: 12, horizontal: TSizes.defaultSpace), // Less padding

            child: arrow_header(
              onpressed: () => Get.back(canPop: true),
            ),
          ),
          //movable
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  left: TSizes.defaultSpace,
                  bottom: TSizes.defaultSpace,
                  right: TSizes.defaultSpace,
                  top: 4,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Payment ',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),

                    //image
                    Image(
                      image: AssetImage(
                        TImages.creditCard,
                      ),
                      width: MediaQuery.of(context).size.width,
                    ),

                    //form for details
                    SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),

                    Form(
                        key: paymentformkey,
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: TextFormField(
                                controller: cardNumberController,
                                validator: (value) =>
                                    TValidator.validateEmptyText(
                                        "Card Number", value),
                                decoration: InputDecoration(
                                  labelText: "Card Number",
                                  hintText: "1111   2222   3333   4444",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        15), // Circular border
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                        color: Colors.grey
                                            .shade100), // Default border color
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
                            const SizedBox(height: 16),

                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: TextFormField(
                                      controller: expDateController,
                                      validator: (value) =>
                                          TValidator.validateEmptyText(
                                              "Expiry Date", value),
                                      decoration: InputDecoration(
                                        labelText: "Exp Date",
                                        hintText: "03/25",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              15), // Circular border
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                              color: Colors.grey
                                                  .shade100), // Default border color
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 11, 77, 127),
                                              width: 2),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: TextFormField(
                                      controller: cvvController,
                                      validator: (value) =>
                                          TValidator.validateEmptyText(
                                              "CVV", value),
                                      decoration: InputDecoration(
                                        labelText: "CVV",
                                        hintText: "123",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              15), // Circular border
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                              color: Colors.grey
                                                  .shade100), // Default border color
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 11, 77, 127),
                                              width: 2),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: DropdownButtonFormField<String>(
                                        dropdownColor:
                                            Colors.amber,
                                        validator: (value) =>
                                            TValidator.validateEmptyText(
                                                "Country", value),
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      15), // Circular border
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .shade100), // Default border color
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 11, 77, 127),
                                                  width: 2),
                                            ),
                                            labelText: "Country"),
                                        value: "Pakistan",
                                        items: [
                                          "Pakistan",
                                          "USA",
                                          "UK",
                                          "India"
                                        ]
                                            .map((e) => DropdownMenuItem(
                                                value: e, child: Text(e)))
                                            .toList(),
                                        onChanged: (val) {
                                          setState(() {
                                            selectedCountry = val!;
                                          });
                                        }),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: TextFormField(
                                      controller: postCodeController,
                                      validator: (value) =>
                                          TValidator.validateEmptyText(
                                              "Post Code", value),
                                      decoration: InputDecoration(
                                        labelText: "Post Code",
                                        hintText: "12345",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              15), // Circular border
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                              color: Colors.grey
                                                  .shade100), // Default border color
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 11, 77, 127),
                                              width: 2),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            //button
                            SizedBox(
                              height: TSizes.spaceBtwItems,
                            ),
                            cartbtn(
                              onpressed: () {
                                if (paymentformkey.currentState!.validate()) {
                                  print(
                                      "Card Number: ${cardNumberController.text}");
                                  print(
                                      "Expiry Date: ${expDateController.text}");
                                  print("CVV: ${cvvController.text}");
                                  print("Country: ${selectedCountry}");
                                  print(
                                      "Post Code: ${postCodeController.text}");
                                  TLoaders.successSnackBar(
                                      title: 'Congratulations!',
                                      message:
                                          'Payment Detail Added Successfully');
                                  // Navigate to Home Screen if validation is successful
                                 
                                }
                              },
                              title: 'Save',
                            )
                          ],
                        ))
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
