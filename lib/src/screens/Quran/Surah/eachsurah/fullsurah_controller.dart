import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SurahDetailController extends GetxController {
  var surahDetails = {}.obs;

  void fetchSurahDetails(int surahId) async {
    try {
      // Load the JSON file from assets
      String jsonString = await rootBundle.loadString('assets/quran/quran.json');
      // Decode the JSON string
      final List<dynamic> data = jsonDecode(jsonString);
      // Find the surah with the specified ID
      final surahData = data.firstWhere((surah) => surah['id'] == surahId, orElse: () => {});
      surahDetails.value = surahData;
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching surah details: $e');
      }
    }
  }
}
