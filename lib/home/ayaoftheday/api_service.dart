import 'dart:convert';
import 'dart:math';

import 'aya_of_the_day.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<AyaoftheDay> getAyaOfTheDay() async {
    String url =
        'http://api.alquran.cloud/v1/ayah/${(random(1, 6237))}/editions/quran-uthmani,en.asad,en.pickthall';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return AyaoftheDay.fromJSON(json.decode(response.body));
    } else {
      print('Failed to Load');

      throw Exception('Failed to Load the Post');
    }
  }

  random(min, max) {
    var rn = Random();
    return min + rn.nextInt(max - min);
  }
}
