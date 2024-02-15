import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartprayer/src/data/model/user_model.dart';
import 'package:smartprayer/src/data/repository/authentication_repository.dart';
import 'package:smartprayer/src/data/repository/user/user_repository.dart';
import 'package:smartprayer/src/helper/networkmanager/networkmanager.dart';
import 'package:smartprayer/src/popups/loader.dart';
import 'package:smartprayer/src/popups/screenloader.dart';
import 'package:smartprayer/src/screens/email_verifcation.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final hidepassword = true.obs;
  final privacy = false.obs;
  final email = TextEditingController();
  final lastname = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final phoneno = TextEditingController();
  final fisrtname = TextEditingController();

  GlobalKey<FormState> signupFormkey = GlobalKey<FormState>();

  void signUp() async {
    try {
      FullScreenLoader.openLoadingDialog(
          'We are processing your information.....',
          'assets/animation/processing.json');

      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }
      if (!signupFormkey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        /* MySnackBar.warningSnackBar(title: "Please fill all the fields", message: "To create account please ensure you fill the fields correctly");*/
        return;
      }

      if (!privacy.value) {
        FullScreenLoader.stopLoading();
        MySnackBar.warningSnackBar(
            title: 'Accept Privacy Policy',
            message:
                'In order to create account, You must have to accept the Privacy Policy & Terms of Use');

        return;
      }

      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());
      final newUser = UserModel(
          id: userCredential.user!.uid,
          firstName: fisrtname.text.trim(),
          lastName: lastname.text.trim(),
          username: username.text.trim(),
          email: email.text.trim(),
          phoneNumber: phoneno.toString().trim(),
          profilePicture: '');

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);
      FullScreenLoader.stopLoading();
      MySnackBar.SuccessSnackBar(
          title: 'Congratulations',
          message: 'Your Account has been Created! Verify email to continue.');

      Get.to(() =>  VerifyEmail(email: email.text.trim(),));
    } catch (e) {
      FullScreenLoader.stopLoading();
      MySnackBar.warningSnackBar(title: 'Oh Snap!', message: e.toString());
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
