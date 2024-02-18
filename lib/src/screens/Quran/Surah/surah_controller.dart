import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SurahController extends GetxController {
  var surahData = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    fetchSurahData();
    super.onInit();
  }

  Future<void> fetchSurahData() async {
    try {
      String data = await rootBundle.loadString('assets/quran/chapters.json');
      List<dynamic> surahList = jsonDecode(data);
      surahData.value = surahList.cast<Map<String, dynamic>>();
    } catch (e) {
      throw Exception('Failed to load surah data: $e');
    }
  }
}
