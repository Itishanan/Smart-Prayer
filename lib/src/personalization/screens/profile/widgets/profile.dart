import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:iconsax/iconsax.dart';
import 'package:smartprayer/src/common_widgets/t_circularimage.dart';
import 'package:smartprayer/src/personalization/screens/settings/settings.dart';

import 'profile_menu.dart';

class ProfileScreeneg extends StatelessWidget {
  ProfileScreeneg({super.key});

  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(const SettingScreen());
            },
            icon: const Icon(Iconsax.settings),
          )
        ],
      ),

      /// --Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              ///-- Profile Picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    TCircularImage(
                      image: user?.photoURL ?? '',
                      isNetworkImage: user?.photoURL != null,
                      width: 80,
                      height: 80,
                    ),
                    TextButton(
                        onPressed: () {},
                        child: const Text('change profile piccture')),
                  ],
                ),
              ),

              /// -- Details
              const SizedBox(height: 8.0 / 2),
              const Divider(),
              const SizedBox(height: 8.0),

              /// Heading Profile Info
/*
              ProfileMenu(onPressed: () {}, title: 'Profile Menu', value: ''),
*/
              const SizedBox(height: 8.0),

              ProfileMenu(
                title: 'Name',
                onPressed: () {} ,
                value: 'null $user',
              ),
              ProfileMenu(
                title: 'UserName',
                value: 'WaleedShahid24',
                onPressed: () {},
              ),

              const SizedBox(height: 8.0),
              const Divider(),
              const SizedBox(height: 8.0),

              /// Heading Profile Info
              const SizedBox(height: 8.0),

              ProfileMenu(
                title: 'UserID',
                value: '240301',
                icon: Iconsax.copy,
                onPressed: () {},
              ),
              ProfileMenu(
                title: 'E-Mail',
                value: 'user',
                onPressed: () {},
              ),
              ProfileMenu(
                title: 'Phone Number',
                value: '0318-6170099',
                onPressed: () {},
              ),
              ProfileMenu(
                title: 'Gender',
                value: 'male',
                onPressed: () {},
              ),
              ProfileMenu(
                title: 'Date of Birth',
                value: '24 march 2001',
                onPressed: () {},
              ),
              const Divider(),
              const SizedBox(height: 8.0),

              Center(
                child: TextButton(
                  onPressed: () {},
                  child: const Text('Create Account',
                      style: TextStyle(color: Colors.red)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
