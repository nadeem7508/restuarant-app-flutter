import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zainab_restuarant_app/pages/app/cart/screens/confirm_order.dart';
import 'package:zainab_restuarant_app/pages/app/cart/screens/widgets/orderdetail_listtile.dart';
import 'package:zainab_restuarant_app/pages/app/cart/screens/widgets/summary_payment.dart';
import 'package:zainab_restuarant_app/pages/registration/reset_password/widgets/arrow_header.dart';
import 'package:zainab_restuarant_app/utils/constants/sizes.dart';

class OrderDetails extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  const OrderDetails({super.key, required this.cartItems});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  late List<Map<String, dynamic>> updatedCartItems;
  double subtotal = 0;
  final double deliveryCharges = 300;
  final double discount = 200;

  @override
  void initState() {
    super.initState();
    updatedCartItems = List.from(widget.cartItems);
    subtotal = updatedCartItems.fold(
      0.0,
      (sum, item) => sum + ((item['totalPrice'] as num?)?.toDouble() ?? 0),
    );
  }

  void calculateSubtotal() {
    setState(() {
      subtotal = updatedCartItems.fold(
        0.0,
        (sum, item) => sum + ((item['totalPrice'] as num?)?.toDouble() ?? 0),
      );
    });
  }

  void updateProduct(int index, Map<String, dynamic> updatedProduct) {
    setState(() {
      updatedCartItems[index] = updatedProduct;
      calculateSubtotal();
    });
  }

  @override
  Widget build(BuildContext context) {
    double total = subtotal + deliveryCharges - discount;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              arrow_header(
                onpressed: () => Get.back(canPop: true),
              ),
              SizedBox(height: TSizes.spaceBtwItems),
              Text(
                'Order Details',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: TSizes.spaceBtwSections),

              // ListTiles
              Expanded(
                child: updatedCartItems.isEmpty
                    ? Center(child: Text("No items in the cart"))
                    : ListView.builder(
                        itemCount: updatedCartItems.length,
                        itemBuilder: (context, index) {
                          return OrderDetailListTile(
                            product: updatedCartItems[index],
                            onUpdate: (updatedProduct) {
                              updateProduct(index, updatedProduct);
                            },
                          );
                        },
                      ),
              ),
              SizedBox(height: TSizes.spaceBtwSections),

              // Summary of Payment
              Container(
                height: 210,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.amber.shade300,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    summary_payment(title: 'Sub-Total', price: 'RS $subtotal'),
                    summary_payment(title: 'Delivery Charges', price: 'RS $deliveryCharges'),
                    summary_payment(title: 'Discount', price: 'RS -$discount'),
                    SizedBox(height: TSizes.spaceItems),
                    summary_payment(title: 'Total', price: 'RS $total'),

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
                          onPressed: () => Get.to(() => ConfirmOrder(
                                subtotal: subtotal,
                                deliveryCharges: deliveryCharges,
                                discount: discount,
                                total: total,
                              )),
                          child: Text('Place My Order', style: TextStyle(color: Colors.amber)),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
