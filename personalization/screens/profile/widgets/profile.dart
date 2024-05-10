import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:new_app/common/widgets/appbar/appbar.dart';
import 'package:new_app/common/widgets/images/t_circularimage.dart';
import 'package:new_app/common/widgets/text/section_heading.dart';
import 'package:new_app/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:new_app/utils/constants/sizes.dart';

import '../../../../../utils/constants/image_strings.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const TAppBar(showBackArrow: true,title: Text('Profile')),
      /// --Body
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              ///-- Profile Picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    const TCircularImage(image: TImages.user,width: 80, height: 80,),
                    TextButton(onPressed: (){}, child: const Text('change profile piccture')),


                  ],
                ),
              ),

              /// -- Details
              const SizedBox(height: TSizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Heading Profile Info
              const TSectionHeading(title: 'Profile Information', showActionButton: false,),
              const SizedBox(height: TSizes.spaceBtwItems ),

              ProfileMenu(title: 'Name', value: 'Waleed Shahid', onPressed: () {  },),
              ProfileMenu(title: 'UserName', value: 'WaleedShahid24', onPressed: () {  },),

              const SizedBox(height: TSizes.spaceBtwItems ),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),


              /// Heading Profile Info
              const TSectionHeading(title: 'Personal Information', showActionButton: false,),
              const SizedBox(height: TSizes.spaceBtwItems ),

              ProfileMenu(title: 'UserID', value: '240301',icon: Iconsax.copy, onPressed: () {  },),
              ProfileMenu(title: 'E-Mail', value: 'waleedch2403@gmail.com', onPressed: () {  },),
              ProfileMenu(title: 'Phone Number', value: '0318-6170099', onPressed: () {  },),
              ProfileMenu(title: 'Gender', value: 'male', onPressed: () {  },),
              ProfileMenu(title: 'Date of Birth', value: '24 march 2001', onPressed: () {  },),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              Center(
                child: TextButton(
                  onPressed: (){},
                  child: const Text('Create Account', style: TextStyle(color: Colors.red)),

                ),
              )


            ],
          ),
        ),
      ),
    );
  }
}

