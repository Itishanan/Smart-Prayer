import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartprayer/src/common_widgets/styles/spacing_style.dart';
import 'package:smartprayer/src/data/repository/authentication_repository.dart';

import 'login.dart';
class VerificationSuccessfull extends StatelessWidget {
  const VerificationSuccessfull({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Padding(
          padding: SpacingStyle.paddingWithAppBarHeight*2,
          child: Column(
            children: [
              Image(
                image: const AssetImage('assets/images/login/success.png'),
                width: MediaQuery.of(context).size.width / 2,
              ),
              const SizedBox(height: 32.0),
              Text(
                'Your Account Created Successfully',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8.0),
              Text(
                'Unlock the secrets to serene prayer experiences, one step at a time, through our personalized guidance.',
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => AuthenticationRepository.instance.screenRedirect(),
                  child: const Text('Continue'),
                ),
              ),
            ],
          ),
        ),
      ),


    );
  }
}
