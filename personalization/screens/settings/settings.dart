import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:iconsax/iconsax.dart';
import 'package:new_app/common/widgets/appbar/appbar.dart';
import 'package:new_app/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:new_app/common/widgets/text/section_heading.dart';
import 'package:new_app/features/personalization/screens/profile/widgets/profile.dart';

import '../../../../common/widgets/list_tiles/setting_menu_tiles.dart';
import '../../../../common/widgets/list_tiles/user_profile_tile.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../address/address.dart';
class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// -- Header
            TPrimaryHeaderContainer(
                child: Column(
                  children: [
                 TAppBar(title: Text('Account', style: Theme.of(context).textTheme.headlineMedium!.apply(color: TColors.white))),
                    /// user profile card
                    TUserProfileTile( onPressed : () => Get.to(() => const ProfileScreen())),
                    const SizedBox(height: TSizes.spaceBtwItems * 2,),

                  ],
    ),
    ),

            /// ---body
            Padding(
               padding: const EdgeInsets.all(TSizes.defaultSpace),
           child: Column(
             children: [
               /// ---ACCOUNT Settings
               const TSectionHeading(title: 'Account Settings', showActionButton: false,),
               const SizedBox(height: TSizes.spaceBtwItems,),

                SettingsMenuTile(icon: Iconsax.safe_home,title: 'My Addresses', subTitle: 'Set shipping delivery address',onTap: () => Get.to(() => const UserAddressScreen()) , ),
               const SettingsMenuTile(icon: Iconsax.shopping_cart,title: 'My Cart', subTitle: 'Add, remove products and move to checkout', ),
               const SettingsMenuTile(icon: Iconsax.bag_tick,title: 'My Orders', subTitle: 'In-progress and completed orders', ),
               const SettingsMenuTile(icon: Iconsax.bank,title: 'Bank Account', subTitle: 'withdraw balance to registered bank account', ),
               const SettingsMenuTile(icon: Iconsax.discount_shape,title: 'My Coupons', subTitle: 'List of all the discounted coupons', ),
               const SettingsMenuTile(icon: Iconsax.notification,title: 'Notifications', subTitle: 'Set any kind of notification messages', ),
               const SettingsMenuTile(icon: Iconsax.security_card,title: 'Account Privacy', subTitle: 'manage data usage and conections', ),

               /// -- App Settings
               const SizedBox(height: TSizes.spaceBtwSections),
               const TSectionHeading(title: 'App Settings', showActionButton: false),
               const SizedBox(height: TSizes.spaceBtwItems),
               const SettingsMenuTile(icon: Iconsax.document_upload, title: 'Load Data', subTitle: 'Upload data to your cloud Firebase'),
               SettingsMenuTile(
                 icon: Iconsax.location,
                 title: 'Geolocation',
                 subTitle: 'set recommendations based on location',
                 trailing: Switch(value: true,onChanged: (value) {},),
               ),
               SettingsMenuTile(
                 icon: Iconsax.security_user,
                 title: 'Safe Mode',
                 subTitle: 'Search results safe for all ages',
                 trailing: Switch(value: false,onChanged: (value) {},),
               ),
               SettingsMenuTile(
                 icon: Iconsax.image,
                 title: 'HD image Quality',
                 subTitle: 'set image quality to be seen',
                 trailing: Switch(value: false,onChanged: (value) {},),
               ),

               /// -- logout button
               const SizedBox(height: TSizes.spaceBtwSections,),
               SizedBox(
                 width: double.infinity,
                 child: OutlinedButton(onPressed: (){},child: const Text('Logout')),
               ),
               const SizedBox(height: TSizes.spaceBtwSections * 2,)

             ],

           ),

           )
          ],
        ),
    ),
    );
  }
}

