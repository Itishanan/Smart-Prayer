import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:smartprayer/src/data/repository/authentication_repository.dart';
import 'package:smartprayer/src/features/authentication/controllers/verify_email_controller.dart';



class VerifyEmail extends StatelessWidget {
  const VerifyEmail({super.key, this.email});

  final String? email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put( VerifyEmailController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => AuthenticationRepository.instance.logout(),
            icon: const Icon(Icons.clear),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image(
                image:
                    const AssetImage('assets/images/login/email_recieve.gif'),
                width: MediaQuery.of(context).size.width / 2,
              ),
              const SizedBox(height: 32.0),
              Text(
                'Verify Your email address!',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8.0),
              Text(
                email ?? '',
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8.0),
              Text(
                "Congratulations! Your Account Awaits: Verify Your Email to Welcome aboard! Let's elevate your prayers together, unveiling a path to mindful and correct prayer practice.",
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => controller.checkEmailVerifcationStatus(),
                  child: const Text('Continue'),
                ),
              ),
              const SizedBox(height: 8.0),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => controller.sendEmailVerifcation(),
                  child: const Text('Resend Email'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
