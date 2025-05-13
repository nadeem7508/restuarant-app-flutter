import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zainab_restuarant_app/pages/app/cart/screens/rating_screen.dart';
import 'package:zainab_restuarant_app/pages/app/cart/screens/widgets/confirmorder_location.dart';
import 'package:zainab_restuarant_app/pages/app/cart/screens/widgets/confirmorder_payment.dart';
import 'package:zainab_restuarant_app/pages/app/cart/screens/widgets/summary_payment.dart';
import 'package:zainab_restuarant_app/pages/registration/reset_password/widgets/arrow_header.dart';
import 'package:zainab_restuarant_app/utils/constants/sizes.dart';
import 'package:zainab_restuarant_app/utils/popups/loaders.dart';

class ConfirmOrder extends StatelessWidget {
  final double subtotal;
  final double deliveryCharges;
  final double discount;
  final double total;

  const ConfirmOrder({
    super.key,
    required this.subtotal,
    required this.deliveryCharges,
    required this.discount,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              arrow_header(onpressed: () => Get.back(canPop: true)),
              SizedBox(height: TSizes.spaceBtwItems),
              Text(
                'Confirm Order',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: TSizes.spaceBtwSections),

              // Options for location and payment
              Expanded(
                child: ListView(
                  children: [
                    ConfirmorderLocation(),
                    SizedBox(height: TSizes.spaceBtwItems),
                    ConfirmOrderPayment(),
                  ],
                ),
              ),

              // Summary of Payment
              SizedBox(height: TSizes.spaceBtwSections),
              Container(
                height: 230,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.amber.shade300,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    summary_payment(title: 'Sub-Total', price: 'RS ${subtotal.toStringAsFixed(2)}'),
                    summary_payment(title: 'Delivery Charges', price: 'RS ${deliveryCharges.toStringAsFixed(2)}'),
                    summary_payment(title: 'Discount', price: 'RS -${discount.toStringAsFixed(2)}'),
                    SizedBox(height: TSizes.spaceItems),
                    summary_payment(title: 'Total', price: 'RS ${total.toStringAsFixed(2)}'),

                    // Place Order Button
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Container(
                        height: 55,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Get.to(() => RatingScreen());
                            TLoaders.successSnackBar(
                              title: 'Congratulations!',
                              message: 'Order Confirmed Successfully',
                            );
                          },
                          child: Text('Place My Order', style: TextStyle(color: Colors.amber)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
