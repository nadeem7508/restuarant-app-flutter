import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zainab_restuarant_app/pages/app/home/screens/menu/product_details/widgets/TCurvedEdgesWidget.dart';
import 'package:zainab_restuarant_app/pages/registration/reset_password/widgets/arrow_header.dart';
import 'package:zainab_restuarant_app/utils/constants/image_strings.dart';

class product_detail_header extends StatelessWidget {
   final dynamic submenu;
  const product_detail_header({
    super.key,required this.submenu,
  });

  @override
  Widget build(BuildContext context) {
     String? imageUrl = submenu != null && submenu.containsKey('imageUrl')
        ? submenu['imageUrl']
        : null;
    return TCurvedEdgesWidget(
        child: Container(
      width: double.infinity,
      height: 250,
      child: Stack(
        children: [
          imageUrl != null && imageUrl.isNotEmpty
                ? Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        TImages.productImage2,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      );
                    },
                  )
                : Image.asset(
                    TImages.productImage2,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
          Positioned(
            top: 10,
            left: 10,
            child: arrow_header(
              onpressed: () => Get.back(canPop: true),
            ),
          ),
        ],
      ),
    ));
  }
}
