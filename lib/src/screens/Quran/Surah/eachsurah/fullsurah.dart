import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'fullsurah_controller.dart';

class SurahDetailScreen extends StatelessWidget {
  final int surahId;
  final SurahDetailController _surahDetailController =
      Get.put(SurahDetailController());

  SurahDetailScreen({Key? key, required this.surahId}) : super(key: key) {
    _surahDetailController.fetchSurahDetails(surahId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        excludeHeaderSemantics: true,
        title: Text('Surah Details',style: TextStyle(color: Colors.blue),),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Obx(() {
          if (_surahDetailController.surahDetails.isEmpty) {
            return Center(child: CircularProgressIndicator());
          } else {
            return _buildSurahDetails(_surahDetailController.surahDetails);
          }
        }),
      ),
    );
  }

  Widget _buildSurahDetails(RxMap<dynamic, dynamic> surahDetails) {
    final Map surahDetailsMap = surahDetails.value;
    // Now surahDetailsMap is of type Map<String, dynamic>
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 250,
          width: double.infinity,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
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
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(100),
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              topRight: Radius.circular(100),
            ),
          ),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Positioned(
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
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                ),
              ),//ARABIC NAME
              Positioned(
                top: 80,
                left: 100,
                child: Text(
                  ' ${surahDetails['translation']}',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),//ENGLISH NAME
              Positioned(
                top: 140,
                left: 100,
                child: Row(
                  children: [
                    Text(
                      '${surahDetails['type']}'.toUpperCase(),
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    Text(
                      ' ${surahDetails['total_verses']} VERSES',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),

                  ],
                ),
              ), //TYPE
             //TOTAL VERSES
              Positioned(
              top: 50,
                child: Container(
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
                  painter: LinePainter(),
                  child: Container(),
                ),
              ),// LINE
            ],
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Verses:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: (surahDetails['verses'] as List).map<Widget>((verse) {
            return ListTile(

              leading: Text(
                '${verse['id']}',
                style: TextStyle(fontSize: 20, color: Colors.black),
            ),
              title: Text(verse['text'],style: TextStyle(fontSize: 30),),
              subtitle: Text(verse['translation']),
            );
          }).toList(),
        ),
      ],
    );
  }
}


class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1.0
      ..strokeCap = StrokeCap.round;

    Offset startPoint = Offset(70, 0); // Adjust these points as needed
    Offset endPoint = Offset(250, 0); // Adjust these points as needed

    canvas.drawLine(startPoint, endPoint, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

