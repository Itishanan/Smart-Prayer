import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'loader.dart';

class FullScreenLoader {

  static void openLoadingDialog(String text, String animation) {

    showDialog(
      context: Get.overlayContext!, // Use Get.overlayContext for overlay dialogs
      barrierDismissible: false, // The dialog can't be dismissed by tapping outside it
      builder: (_) => PopScope(
        canPop: false,
        // Disable popping with the back button
        child: Container(
          color: Colors.white,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               // Adjust the spacing as needed
              AnimationLoaderWidget(text: text, animation: animation),
            ],
          ),
        ),
      ),
    );
  }
  static stopLoading(){

    Navigator.of(Get.overlayContext!).pop();
  }
}
