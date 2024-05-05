import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:iconsax/iconsax.dart';
import 'package:smartprayer/src/screens/Quran/quran_screen.dart';

import 'package:smartprayer/src/screens/main_menu.dart';

import '../screens/ai_screen.dart';
import '../screens/namaz_tracker.dart';
import '../screens/profile_screen.dart';

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
          destinations: const [
            Center(
                child: NavigationDestination(
                    icon: Icon(Iconsax.home), label: 'Home')),
            NavigationDestination(icon: Icon(Iconsax.activity), label: 'A.I'),
            NavigationDestination(icon: Icon(Iconsax.book), label: 'Quran'),
            Center(
              child: NavigationDestination(
                  icon: Icon(Iconsax.calendar_edit), label: 'Namaz Log'),
            ),
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
    aiscreen(),
    QuranScreen(),
    NamazTracker(),
   ProfileScreen(),
  ];
}
