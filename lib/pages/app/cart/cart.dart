import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:zainab_restuarant_app/pages/app/cart/screens/order_details.dart';
import 'package:zainab_restuarant_app/pages/app/cart/widgets/cartlisttile.dart';
import 'package:zainab_restuarant_app/pages/app/home/screens/menu/product_details/widgets/cartbtn.dart';
import 'package:zainab_restuarant_app/pages/app/home/widgets/home_header.dart';
import 'package:zainab_restuarant_app/pages/app/provider/cart_provider.dart';
import 'package:zainab_restuarant_app/utils/constants/sizes.dart';
import 'package:zainab_restuarant_app/utils/constants/text_strings.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.items;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              home_header(title: "Cart"),
              SizedBox(height: TSizes.spaceBtwSections),
              Expanded(
                child: cartItems.isEmpty
                    ? Center(
                        child: Text(
                          "Your cart is empty",
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                      )
                    : ListView.builder(
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          return cart_listtile(
                            product: cartItems[index],
                            onRemove: () {
                              final productId = cartItems[index]['id'];

                              if (productId != null) {
                                cartProvider.removeFromCart(productId);
                                Get.snackbar(
                                    "Removed", "Product removed from cart!");
                              } else {
                                Get.snackbar("Error",
                                    "Cannot remove item: ID is missing.");
                              }
                            },
                          );
                        },
                      ),
              ),
              SizedBox(height: TSizes.spaceBtwItems),
              cartItems.isNotEmpty
                  ? cartbtn(
                      onpressed: () => Get.to(() => OrderDetails(cartItems: cartItems,)),
                      title: TTexts.checkout,
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
