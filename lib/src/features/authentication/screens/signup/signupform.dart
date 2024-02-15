import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smartprayer/src/features/authentication/controllers/signup_controller.dart';
import 'package:smartprayer/src/helper/validator/validator.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());

    return Form(
      key: controller.signupFormkey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  validator: (value) =>
                      Validator.validateEmptyText(value, 'First Name'),
                  controller: controller.fisrtname,
                  keyboardType: TextInputType.name,
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: 'First Name',
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
              const SizedBox(
                width: 16.0,
              ),
              Expanded(
                child: TextFormField(
                  controller: controller.lastname,
                  validator: (value) =>
                      Validator.validateEmptyText(value, 'Last Name'),
                  keyboardType: TextInputType.name,
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16.0,
          ),
          TextFormField(
            controller: controller.username,
            validator: (value) =>
                Validator.validateEmptyText(value, 'UserName'),
            expands: false,
            decoration: const InputDecoration(
              labelText: 'Username',
              prefixIcon: Icon(Iconsax.user_edit),
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          TextFormField(
            validator: (value) => Validator.validateEmail(value),
            controller: controller.email,
            keyboardType: TextInputType.emailAddress,
            expands: false,
            decoration: const InputDecoration(
              labelText: 'E-Mail ',
              prefixIcon: Icon(Iconsax.direct),
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          TextFormField(

            validator: (value) =>
                Validator.validatePhoneNumber(value),
            controller: controller.phoneno,
            expands: false,
            decoration: const InputDecoration(
              labelText: 'Phone Number',
              prefixIcon: Icon(Iconsax.call),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Obx(
            () => TextFormField(
              validator: (value) => Validator.validatePassword(value),
              controller: controller.password,
              obscureText: controller.hidepassword.value,
              expands: false,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  onPressed: () => controller.hidepassword.value =
                      !controller.hidepassword.value,
                  icon: const Icon(
                      Iconsax.eye_slash), // Material Icons eye slash icon
                ),
                prefixIcon: const Icon(Iconsax.password_check),
              ),
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Row(
            children: [
              SizedBox(
                  width: 24.0,
                  height: 24.0,
                  child: Obx(() => Checkbox(
                      value: controller.privacy.value,
                      onChanged: (value) => controller.privacy.value =
                          !controller.privacy.value))),
              const SizedBox(
                width: 2.0,
              ),
              Text.rich(
                TextSpan(children: [
                  TextSpan(
                      text: 'I Agree to ',
                      style: Theme.of(context).textTheme.bodySmall),
                  TextSpan(
                      text: 'Privacy Policy',
                      style: Theme.of(context).textTheme.bodyMedium!.apply(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          )),
                  TextSpan(
                      text: ' and ',
                      style: Theme.of(context).textTheme.bodySmall),
                  TextSpan(
                      text: 'Agree to Use ',
                      style: Theme.of(context).textTheme.bodyMedium!.apply(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          )),
                ]),
              )
            ],
          ),
          const SizedBox(
            height: 32.0,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.signUp(),
              child: const Text("Create Account"),
            ),
          )
        ],
      ),
    );
  }
}
