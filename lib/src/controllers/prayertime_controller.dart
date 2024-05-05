import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:adhan/adhan.dart';

class PrayerTime {
  final String name;
  final DateTime time;


  PrayerTime({required this.name, required this.time});
}

class PrayerTimesController extends GetxController {
  final RxList<PrayerTime> _prayerTimes = <PrayerTime>[].obs;
  List<PrayerTime> get prayerTimes => _prayerTimes;

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

      _prayerTimes.assignAll([
        PrayerTime(name: 'Fajr', time: prayerTimes.fajr),
        PrayerTime(name: 'Dhuhr', time: prayerTimes.dhuhr),
        PrayerTime(name: 'Asr', time: prayerTimes.asr),
        PrayerTime(name: 'Maghrib', time: prayerTimes.maghrib),
        PrayerTime(name: 'Isha', time: prayerTimes.isha),
        PrayerTime(name: 'Sunrise', time: prayerTimes.sunrise),

      ]);
    } catch (e) {
      if (kDebugMode) {
        print('Error getting prayer times: $e');
      }
    }
  }
}
