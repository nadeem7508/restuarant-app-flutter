import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zainab_restuarant_app/pages/app/home/models/home_model.dart';
import 'package:zainab_restuarant_app/pages/app/home/screens/specialoffers/specialoffer.dart';
import 'package:zainab_restuarant_app/pages/app/home/widgets/grid_layout.dart';
import 'package:zainab_restuarant_app/pages/app/home/widgets/home_banner.dart';
import 'package:zainab_restuarant_app/pages/app/home/widgets/home_header.dart';
import 'package:zainab_restuarant_app/pages/app/home/widgets/home_vertical_items.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zainab_restuarant_app/utils/constants/image_strings.dart';
import 'package:zainab_restuarant_app/utils/constants/sizes.dart';
import 'package:zainab_restuarant_app/utils/popups/loaders.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
   bool hasClaimedOffer = false;

  @override
  void initState() {
    super.initState();
    _checkOfferStatus();
  }

  // **Check if user has already claimed the offer**
  Future<void> _checkOfferStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      hasClaimedOffer = prefs.getBool('hasClaimedOffer') ?? false;
    });
  }

  // **Handle banner click**
  Future<void> _onBannerClick() async {
    if (hasClaimedOffer) {
      TLoaders.errorSnackBar(
          title: "Offer Unavailable",
          message: "You have already claimed this special offer.");
      return;
    }

    // **Mark offer as claimed**
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasClaimedOffer', true);

    // **Navigate to special offer page**
    Get.to(() => Specialoffer());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  //header-home
                  home_header(
                    title: 'Home',
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
         // **Home Banners with Click Logic**
                GestureDetector(
                  onTap: _onBannerClick,
                  child: home_banner(
                    image1: TImages.promoBanner1,
                    image2: TImages.promoBanner2,
                  ),
                ),
                  SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
        //gridview of items
                  grid_layout(
                    itemcount: items.length,
                    mainaxisextent: 150,
                     crossaxiscount: 2,
                    itemBuilder: (context, index) => home_vertical_items(index:index), scrollDirection: Axis.vertical,
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
