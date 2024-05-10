import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:new_app/utils/constants/colors.dart';
import 'package:new_app/utils/helpers/helper_functions.dart';

import '../../../../../common/widgets/custom_shapes/containers/TRoundedContainer.dart';
import '../../../../../utils/constants/sizes.dart';
class TSingleAddress extends StatelessWidget {
  const TSingleAddress
      ({super.key, required this.selectedAddress});
  final bool selectedAddress;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return TRoundedContainer(
      width: double.infinity,
      showBorder: true,
      padding: const EdgeInsets.all(TSizes.md),
      backgroundColor: selectedAddress ? TColors.primary.withOpacity(0.5): Colors.transparent ,
      borderColor: selectedAddress ? Colors.transparent : dark ? TColors.darkerGrey : TColors.grey,
      margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
child: Stack(
  children: [
    Positioned(
      right: 5,
      top: 0,
      child: Icon(
        selectedAddress ? Iconsax.tick_circle5 : null,
      color: selectedAddress
          ? dark
              ? TColors.light
            : TColors.dark.withOpacity(0.5)
        : null,
      ),
    ),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('waleed shahid',
        maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: TSizes.sm / 2,),
        const Text('0318170099', maxLines: 1, overflow: TextOverflow.ellipsis),
        const SizedBox(height: TSizes.sm / 2,),
        Text('01238 1/10-L, Harappa, Sahiwal',
          softWrap: true,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleMedium,
        ),

      ],
    )
  ],
),
    );
  }
}
