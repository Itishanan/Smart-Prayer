import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:smartprayer/src/helper/networkmanager/networkmanager.dart';

class PrayerController extends GetxController {
  final Rx<DateTime> selectedDate = DateTime.now().obs;
  final RxList<bool> prayers = List.generate(5, (_) => false).obs;
  final RxList<bool> previousPrayers = List.generate(5, (_) => false).obs;
  final Rx<DateTime> focusedDay = DateTime.now().obs;
  final Rx<int> streak = 0.obs; // Streak counter
  final Rx<DateTime> lastPrayedDate =
      DateTime.now().subtract(const Duration(days: 1)).obs;
  final NetworkManager networkManager = Get.put(NetworkManager());

  @override
  void onInit() {
    selectedDate.value = DateTime.now();
    focusedDay.value = DateTime.now();
    super.onInit();
  }

  void setDate(DateTime selected, DateTime focused) {
    selectedDate.value = selected;
    focusedDay.value = focused;
    update();
  }

  void togglePrayer(int index, bool value) {
    prayers[index] = value;
    previousPrayers[index] = value;
    update();
  }

  Future<void> savePrayers() async {
    final prayerData = {
      'date': selectedDate.value,
      'prayers': prayers.toList(),
    };

    if (await isConnectedToInternet()) {
      try {
        // Get the current user's ID
        String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

        if (userId.isNotEmpty) {
          await FirebaseFirestore.instance
              .collection('NamazLog') // Collection for users
              .doc(userId) // Document for current user
              .collection(
                  'prayers') // Collection for prayers under the current user
              .doc(selectedDate.value
                  .toString()) // Document for prayers for a specific date
              .set(prayerData);
        SnackBar(content: Text('Data Saved'));
          if (kDebugMode) {
            print("UPdated");
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error saving to Firestore: $e');
        }
      }
    }
  }

  Future<void> fetchPreviousPrayers(DateTime date) async {
    try {
      // Get the current user's ID
      String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

      if (userId.isNotEmpty) {
        final snapshot = await FirebaseFirestore.instance
            .collection('NamazLog') // Collection for users
            .doc(userId) // Document for current user
            .collection(
                'prayers') // Collection for prayers under the current user
            .doc(date.toString()) // Document for prayers for a specific date
            .get();

        Fluttertoast.showToast(msg: "Data Fetched");

        if (snapshot.exists) {
          final data = snapshot.data();
          final List<dynamic>? prayerList = data?['prayers'];

          if (prayerList != null && prayerList.length == 5) {
            previousPrayers.assignAll(List<bool>.from(prayerList));
          }
        } else {
          previousPrayers.assignAll(List.generate(5, (_) => false));
        }
      } else {
        // Handle case where user is not authenticated
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching data: $e');
      }
    }
  }

  Future<bool> isConnectedToInternet() async {
    // Get the current instance of NetworkManager
    final networkManager = NetworkManager.instance;
    // Check if the connection status is not none
    return networkManager.connectionStatus.value != ConnectivityResult.none;
  }

  void completeActivity() {
    if (isPrayedFiveTimes()) {
      if (isNextDay()) {
        streak.value++;
      } else {
        streak.value = 1;
        lastPrayedDate.value = selectedDate.value;
      }
    } else {
      streak.value = 0;
    }
  }

  bool isPrayedFiveTimes() {
    return previousPrayers.every((prayed) => prayed == true);
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  bool isNextDay() {
    final DateTime yesterday = DateTime.now().subtract(const Duration(days: 1));
    return isSameDay(lastPrayedDate.value, yesterday);
  }
}
