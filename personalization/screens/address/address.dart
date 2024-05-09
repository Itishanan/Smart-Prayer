import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:new_app/common/widgets/appbar/appbar.dart';
import 'package:new_app/features/personalization/screens/address/widgets/single_address.dart';
import 'package:new_app/utils/constants/sizes.dart';

import '../../../../utils/constants/colors.dart';
import 'add_new_address.dart';
class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: TColors.primary,
        onPressed: ()=> Get.to(() => const AddNewAddressScreen()),
      child: const Icon(Iconsax.add, color: TColors.white),

    ),
      appBar: TAppBar(
        showBackArrow: true,
        title: Text('Address', style: Theme.of(context).textTheme.headlineSmall,),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              TSingleAddress(selectedAddress: false),
              TSingleAddress(selectedAddress: true),

            ],
          ),
        ),
      ),
    );
  }
}
