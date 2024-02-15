

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:iconsax/iconsax.dart';

import 'package:smartprayer/src/screens/main_menu.dart';

import '../screens/namaz_tracker.dart';

class NavigationMenu extends StatelessWidget {
   const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    return Scaffold(
      bottomNavigationBar: Obx(
            () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
          controller.selectedIndex.value = index,

          destinations:  const [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
            NavigationDestination(icon: Icon(Iconsax.activity), label: 'A.I'),
            NavigationDestination(icon: Icon(Iconsax.book1), label: 'Quran'),
            NavigationDestination(
                icon: Icon(Iconsax.trade1), label: 'Namaz Track'),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
          ],
        ),
      ),
      body: Obx(() {
        return controller.screens[controller.selectedIndex.value];
      }),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final screens = [
    MainMenu(),
    Container(color: Colors.grey,child: const Center(
      child: Text('In Construction'),
    ),),
    Container(color: Colors.blue),
    NamazTracker(),
    Container(color: Colors.yellow),
  ];
}
