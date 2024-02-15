import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartprayer/src/common_widgets/styles/spacing_style.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smartprayer/src/features/authentication/controllers/login_controller.dart';
import 'package:smartprayer/src/helper/validator/validator.dart';
import 'package:smartprayer/src/screens/signup.dart';
import 'package:smartprayer/src/utils/Themes/outlined_button_theme.dart';

import '../common_widgets/login/divider.dart';
import '../common_widgets/login/footer.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: SpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              Column(
                children: [
                  const Image(
                    height: 150,
                    image: AssetImage('assets/images/logo/applogo.png'),
                  ),
                  Text('Welcome Back',
                      style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text('Inspiring Devotion, One Tap Away.',
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
              Form(
                key: controller.loginFormKey,
                  child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 32.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.email,
                      validator: (value) => Validator.validateEmail(value),
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.direct_right),
                          labelText: 'E-Mail'),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Obx(
                      () => TextFormField(
                        validator: (value) => Validator.validateEmptyText(value,'Password'),
                        controller: controller.password,
                        obscureText: controller.hidePassword.value,
                        expands: false,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          suffixIcon: IconButton(
                            onPressed: () => controller.hidePassword.value =
                                !controller.hidePassword.value,
                            icon: const Icon(Iconsax
                                .eye_slash), // Material Icons eye slash icon
                          ),
                          prefixIcon: const Icon(Iconsax.password_check),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Obx(() => Checkbox(
                                value: controller.rememberMe.value,
                                onChanged: (value) => controller.rememberMe
                                    .value = !controller.rememberMe.value)),
                            const Text('Remember Me')
                          ],
                        ),
                        TextButton(
                            onPressed: () {},
                            child: const Text("Forget Password?")),
                      ],
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () => controller.emailAmdPasswordSignIn() , child: const Text('Sign In')),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                          style: SOutlinedButtonTheme
                              .lightOutlinedButtonTheme.style,
                          onPressed: () => Get.to(() => const SignupScreen()),
                          child: const Text('Create Account')),
                    ),
                  ],
                ),
              )),
              const login_divider(dividerText: 'Sign in With'),
              const footer_login(),
            ],
          ),
        ),
      ),
    );
  }
}
