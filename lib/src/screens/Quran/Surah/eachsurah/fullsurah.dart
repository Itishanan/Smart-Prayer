import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/linepainter.dart';
import 'fullsurah_controller.dart';

class SurahDetailScreen extends StatelessWidget {
  final int surahId;
  final SurahDetailController _surahDetailController =
      Get.put(SurahDetailController());

  SurahDetailScreen({super.key, required this.surahId}) {
    _surahDetailController.fetchSurahDetails(surahId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        excludeHeaderSemantics: true,
        title: const Text(
          'Surah Details',
          style: TextStyle(color: Colors.blue),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (_surahDetailController.surahDetails.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return _buildSurahDetails(_surahDetailController.surahDetails);
          }
        }),
      ),
    );
  }

  Widget _buildSurahDetails(RxMap<dynamic, dynamic> surahDetails) {

    // Now surahDetailsMap is of type Map<String, dynamic>
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.center,
          height: 250,
          width: double.infinity,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue.shade900,
                Colors.blue.shade100,
              ],
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(100),
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              topRight: Radius.circular(100),
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              const Positioned(
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                child: SizedBox(
                  height: 300,
                  child: Opacity(
                    opacity: 0.2,
                    child: Image(
                      image: AssetImage('assets/quran/quran_bg.png'),
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 30,
                left: 50,
                child: Center(
                  child: Text(
                    ' ${surahDetails['transliteration']}',
                    style: const TextStyle(fontSize: 40, color: Colors.white),
                  ),
                ),
              ), //ARABIC NAME
              Positioned(
                top: 80,
                left: 100,
                child: Text(
                  ' ${surahDetails['translation']}',
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ), //ENGLISH NAME
              Positioned(
                top: 140,
                left: 100,
                child: Row(
                  children: [
                    Text(
                      '${surahDetails['type']}'.toUpperCase(),
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      ' ${surahDetails['total_verses']} VERSES',
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ],
                ),
              ), //TYPE
              //TOTAL VERSES
              const Positioned(
                top: 50,
                child: SizedBox(
                  height: 300,
                  child: Image(
                    image: AssetImage('assets/quran/bsml_ar.png'),
                  ),
                ),
              ), //BSML IMAGE
              Positioned(
                top: 110,
                left: 0,
                right: 10,
                child: CustomPaint(
                  painter: LinePainter(endPoint: const Offset(250, 0) ,startPoint: const Offset(70 ,0 ), color: Colors.white, strokeWidth: 1.0),
                  child: Container(),
                ),
              ), // LINE
            ],
          ),
        ),
        const SizedBox(height: 16),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: (surahDetails['verses'] as List).map<Widget>((verse) {
            return SingleChildScrollView(
              child: Column(

                children: [
                  Column(
                    children: [
                      Container(
                        height: 30,
                        width: 320,
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '${verse['id']}',
                                style: const TextStyle(fontSize: 16, color: Colors.white),
                              ),
                            ),
                            IconButton(
                              alignment: Alignment.topCenter,
                              iconSize: 20,
                              onPressed: () {},
                              icon: const Icon(

                                Icons.bookmark_border,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        alignment: Alignment.bottomRight,
                        width: double.infinity - 20,
                        child: Text(
                          verse['text'],
                          textDirection: TextDirection.rtl,
                          style: const TextStyle(
                            fontSize: 30,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        width: double.infinity,
                        child: Text(
                          verse['translation'],
                        ),
                      ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomPaint(
                          painter: LinePainter(endPoint: const Offset(300, 0) ,startPoint: const Offset(0 ,0 ), color: Colors.blue, strokeWidth: 0.1),),
                        )
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}



