import 'dart:async';

import 'package:get/get.dart';

class ImageController extends GetxController {
  final String morningImage = 'assets/home_page/day_home.gif';
  final String nightImage = 'assets/home_page/night_home.gif';
  final String sunriseImage = 'assets/home_page/sunrise_home.gif';
  final String sunsetImage = 'assets/home_page/sunset_home.gif';

  RxString image = ''.obs;

  @override
  void onInit() {
    super.onInit();
    updateImage(); // Update image initially
    Timer.periodic(const Duration(seconds: 1), (timer) {
      updateImage(); // Update image every minute
    });
  }

  void updateImage() {
    var hour = DateTime.now().hour;
    if (hour >= 5 && hour < 8) {
      image.value = sunriseImage;
    } else if (hour >= 8 && hour < 17) {
      image.value = morningImage;
    } else if (hour >= 17 && hour < 18) {
      image.value = sunsetImage;
    } else {
      image.value = nightImage;
    }
  }
}
