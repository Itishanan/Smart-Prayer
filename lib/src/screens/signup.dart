
import 'package:flutter/material.dart';


import '../common_widgets/login/divider.dart';
import '../common_widgets/login/footer.dart';
import '../features/authentication/screens/signup/signupform.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
            "Let's Create Your Account",
                style: Theme
                    .of(context)
                    .textTheme
                    .headlineMedium,
              ),
              const SizedBox(
                height: 32,
              ),
              const SignupForm(),
              const SizedBox(height: 32.0,),
              const login_divider(dividerText: 'Sign UP With'),
              const footer_login(),
            ],
          ),
        ),
      ),
    );
  }
}

