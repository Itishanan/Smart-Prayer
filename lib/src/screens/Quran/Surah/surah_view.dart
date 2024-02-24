import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartprayer/src/screens/Quran/Surah/surah_controller.dart';

import 'eachsurah/fullsurah.dart';

class SurahView extends StatelessWidget {
  final SurahController _surahController = Get.put(SurahController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (_surahController.surahData.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return SurahListView(surahData: _surahController.surahData);
        }
      }),
    );
  }
}

class SurahListView extends StatelessWidget {
  final RxList<Map<String, dynamic>> surahData;

  const SurahListView({Key? key, required this.surahData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: surahData.length,
      itemBuilder: (context, index) {
        final surah = surahData[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            onTap: () {
              Get.to(SurahDetailScreen(surahId: surah['id']));
              if (kDebugMode) {
                print('Surah ID: ${surah['id']}');
              }
              // Navigate to another screen based on the surah's ID
            },
            child: Container(

              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
               gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.blue,
                    Colors.blueAccent,
                  ],
                ),
                color: Colors.blue.withOpacity(0.03),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),

              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 20,
                      decoration: const BoxDecoration(
                        border: Border(
                          right: BorderSide(color: Colors.blue, width: 0.5),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: Text(
                              ' ${surah['id']}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          surah['transliteration'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Versus ${surah['total_verses']}',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(

                              ' ${surah['type']}'.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      surah['name'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
