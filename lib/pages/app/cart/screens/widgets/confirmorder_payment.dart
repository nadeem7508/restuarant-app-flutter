import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zainab_restuarant_app/utils/constants/image_strings.dart';

class ConfirmOrderPayment extends StatefulWidget {
  const ConfirmOrderPayment({super.key});

  @override
  State<ConfirmOrderPayment> createState() => _ConfirmOrderPaymentState();
}

class _ConfirmOrderPaymentState extends State<ConfirmOrderPayment> {
  String selectedPaymentMethod = "Cash";
  String paymentDetails = "Pay on Delivery";
  String paymentIcon = TImages.paypal; // Default icon

  // 🔹 Function to Redirect to Easypaisa App
  void _launchEasypaisa() async {
    const easypaisaURL = "easypaisa://open"; // Example (change if needed)
    if (await canLaunch(easypaisaURL)) {
      await launch(easypaisaURL);
    } else {
      print("Easypaisa app not installed.");
    }
  }

  // 🔹 Function to Handle Stripe Payment (Dummy Example)
  void _processStripePayment() async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: "your_payment_intent_secret",
          merchantDisplayName: "Zainab Restaurant",
        ),
      );
      await Stripe.instance.presentPaymentSheet();
      setState(() {
        selectedPaymentMethod = "Bank Transfer";
        paymentDetails = "Payment Successful via Stripe";
      });
    } catch (e) {
      print("Stripe Payment Failed: $e");
    }
  }

  // 🔹 Show Payment Options
  void _showPaymentOptions() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Select Payment Method",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              ListTile(
                leading: Icon(Icons.money, color: Colors.green),
                title: Text("Cash on Delivery"),
                onTap: () {
                  setState(() {
                    selectedPaymentMethod = "Cash";
                    paymentDetails = "Pay on Delivery";
                    paymentIcon = TImages.paypal;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.account_balance, color: Colors.blue),
                title: Text("Bank Transfer (Stripe)"),
                onTap: () {
                  Navigator.pop(context);
                  _processStripePayment(); // Call Stripe Payment
                },
              ),
              ListTile(
                leading: Icon(Icons.mobile_friendly, color: Colors.orange),
                title: Text("Easypaisa"),
                onTap: () {
                  Navigator.pop(context);
                  _launchEasypaisa(); // Open Easypaisa
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Payment Method:',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                TextButton(onPressed: _showPaymentOptions, child: Text('Edit')),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image(image: AssetImage(paymentIcon), height: 40),
                Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Text(
                    paymentDetails,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
