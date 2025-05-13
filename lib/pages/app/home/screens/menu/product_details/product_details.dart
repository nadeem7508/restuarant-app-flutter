import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:zainab_restuarant_app/bottomnav.dart';
import 'package:zainab_restuarant_app/pages/app/home/screens/menu/product_details/widgets/cartbtn.dart';
import 'package:zainab_restuarant_app/pages/app/home/screens/menu/product_details/widgets/detail_order.dart';
import 'package:zainab_restuarant_app/pages/app/home/screens/menu/product_details/widgets/detail_title.dart';
import 'package:zainab_restuarant_app/pages/app/home/screens/menu/product_details/widgets/product_description.dart';
import 'package:zainab_restuarant_app/pages/app/home/screens/menu/product_details/widgets/product_detail_header.dart';
import 'package:zainab_restuarant_app/pages/app/provider/cart_provider.dart';
import 'package:zainab_restuarant_app/utils/constants/sizes.dart';
import 'package:zainab_restuarant_app/utils/constants/text_strings.dart';
import 'package:zainab_restuarant_app/utils/popups/loaders.dart';

class ProductDetails extends StatefulWidget {
  final String menuId; // Parent menu ID
  final String submenuId; // Selected submenu ID// Passed submenu data
  final String submenuName;
  final String productId;
  const ProductDetails({
    super.key,
    required this.menuId,
    required this.submenuId,
    required this.submenuName,
    required this.productId,
  });

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map<String, dynamic>? productData;
  bool isLoading = true;

  bool hasError = false;

  @override
  void initState() {
    super.initState();
    _fetchProductDetails();
  }

  void _fetchProductDetails() async {
    try {
      var docSnapshot = await _firestore
          .collection('menus')
          .doc(widget.menuId)
          .collection('submenus')
          .doc(widget.submenuId)
          .collection('products')
          .doc(widget.productId)
          .get();

      if (docSnapshot.exists) {
        setState(() {
          productData = docSnapshot.data();
          productData!['id'] = docSnapshot.id; // ✅ Add document ID manually
          isLoading = false;
        });
      } else {
        setState(() {
          hasError = true;
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        hasError = true;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : hasError
                ? Center(child: Text("No product available"))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: TSizes.defaultSpace),
                        child: product_detail_header(
                          submenu: productData, // Using product data now
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.all(TSizes.defaultSpace),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DetailTitle(
                                  title: productData!['name'] ?? 'Unknown Item',
                                  submenu: productData,
                                ),
                                SizedBox(height: TSizes.spaceBtwItems),
                                Text(
                                  productData!['name'] ?? 'Unknown Item',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .apply(color: Colors.black),
                                ),
                                SizedBox(height: TSizes.spaceBtwItems),
                                Text(
                                  'Price: ${productData!['price'] ?? 0}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .apply(color: Colors.black),
                                ),
                                SizedBox(height: TSizes.spaceBtwItems),
                                detail_order(
                                    isAvailable:
                                        productData!['available'] ?? false),
                                SizedBox(height: TSizes.spaceBtwItems),
                                product_description(
                                  description:
                                      productData!['description'] ?? '',
                                ),
                                SizedBox(height: TSizes.spaceBtwItems),
                                cartbtn(
                                  onpressed: () {
                                    if (productData != null &&
                                        productData!.containsKey('id')) {
                                      cartProvider.addToCart({
                                        'id': productData![
                                            'id'], // ✅ Ensured 'id' exists
                                        'name':
                                            productData!['name'] ?? 'Unknown',
                                        'price': productData!['price'] ?? 0,
                                        'imageUrl':
                                            productData!['imageUrl'] ?? '',
                                      });

                                      TLoaders.successSnackBar(
                                        title: 'Added to Cart!',
                                        message:
                                            '${productData!['name']} added successfully',
                                      );
                                      Get.to(() => Bottomnav());
                                    } else {
                                      TLoaders.errorSnackBar(
                                        title: 'Error',
                                        message:
                                            'Product ID is missing. Cannot add to cart.',
                                      );
                                    }
                                  },
                                  title: TTexts.addcart,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}
