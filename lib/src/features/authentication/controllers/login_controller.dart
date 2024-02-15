import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';


import '../../../data/repository/authentication_repository.dart';
import '../../../helper/networkmanager/networkmanager.dart';
import '../../../popups/loader.dart';
import '../../../popups/screenloader.dart';

class LoginController extends GetxController {
  //variables
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();


   Future <void> emailAmdPasswordSignIn() async {
    try {
      FullScreenLoader.openLoadingDialog(
          'Logging You In....',
          'assets/animation/processing.json');

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }
      if (!loginFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        /* MySnackBar.warningSnackBar(title: "Please fill all the fields", message: "To create account please ensure you fill the fields correctly");*/
        return;
      }
      final userCredentials = await AuthenticationRepository.instance
          .loginWithEmailandPassword(email.text.trim(), password.text.trim());
      AuthenticationRepository.instance.screenRedirect() ;
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
        return;
      }
    } catch (e) {
      FullScreenLoader.stopLoading();
      MySnackBar.warningSnackBar(title: 'Oh Snap!', message: e.toString());
      if (kDebugMode) {
        print(e);
      }
    }
  }
}