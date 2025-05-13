import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zainab_restuarant_app/panel.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  var currentIndex = 0.obs;
  final box = GetStorage();

  void nextPage() {
    if (currentIndex.value < 1) {
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      box.write('seenOnboarding', true);
      Get.off(() => Panel());
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
