import 'package:adhan/adhan.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';

class PrayerTimesController extends GetxController {
  final Rx<PrayerTimes?> _prayerTimes = Rx<PrayerTimes?>(null);
  PrayerTimes? get prayerTimes => _prayerTimes.value;

  final Location location = Location();

  @override
  void onInit() {
    super.onInit();
    _fetchPrayerTimes();
  }

  Future<void> _fetchPrayerTimes() async {
    try {
      var userLocation = await location.getLocation();
      final coordinates = Coordinates(userLocation.latitude!, userLocation.longitude!);
      final params = CalculationParameters(
        method: CalculationMethod.karachi,
        madhab: Madhab.shafi,
        fajrAngle: 18,
        ishaAngle: 18,
      );
      final date = DateComponents.from(DateTime.now());
      final prayerTimes = PrayerTimes(coordinates, date, params);
      _prayerTimes.value = prayerTimes;
    } catch (e) {
      if (kDebugMode) {
        print('Error getting prayer times: $e');
      }
    }
  }
}
