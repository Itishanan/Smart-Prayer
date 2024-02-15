import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'data/model/surah_model.dart';

class Repository {
  final quranBaseUrl = 'https://api.alquran.cloud/v1/surah/114/en.asad';
  final shalahBaseUrl = 'https://api.myquran.com/v1';
  final videoBaseUrl = 'www.googleapis.com';

  Future<List<Surah>> getSurahList() async {
    final response = await http.get(Uri.parse('$quranBaseUrl/surah'));

    try {
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<Surah> surahList = [];
        for (var item in data['data']) {
          surahList.add(Surah.fromJson(item));
        }
        return surahList;
      } else {
        throw Exception('Failed to load surah list');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }

  Future<Surah> getSurahByNumber({required String surahNumber}) async {
    Map<String, String> parameter = {
      'number': surahNumber,
    };

    final response = await http.get(
      Uri.https('apimuslimify.vercel.app', '/api/v2/surah', parameter),
    );

    try {
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final surah = Surah.fromJson(data['data']);
        return surah;
      } else {
        throw Exception('Failed to load surah');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }
}
