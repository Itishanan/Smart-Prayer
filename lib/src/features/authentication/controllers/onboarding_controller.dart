import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smartprayer/src/screens/login.dart';



class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

  /// Variables
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;
  /// Update Current Index when Page Scroll

  void updatePageIndicator(index) => currentPageIndex.value = index;

  /// Jump to the specific dot selected page.

  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.jumpTo(index);
  }

  /// Update Current Index & jump to next page

  void nextPage() {

    if(currentPageIndex.value == 3){
      final storage = GetStorage();
      storage.write('isFirstTime', false);
      Get.offAll( const LoginScreen());
    }
    else{
      int page = currentPageIndex.value + 1;
      pageController.jumpToPage(page);
    }
  }

  void skipPage() {
    currentPageIndex.value =0;
   Get.to(const LoginScreen());
  }
}
