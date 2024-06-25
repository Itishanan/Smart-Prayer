import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:smartprayer/home/ayaoftheday/api_service.dart';

import 'package:smartprayer/src/common_widgets/posturedetectcarousel.dart';
import 'package:smartprayer/src/controllers/home/image_controller_home.dart';
import 'package:smartprayer/src/controllers/prayertime_controller.dart';

import '../../home/ayaoftheday/aya_of_the_day_container.dart';
import '../common_widgets/childactivitescontainer.dart';
import '../common_widgets/prayer_times.dart';

class MainMenu extends StatelessWidget {
  MainMenu({Key? key}) : super(key: key);

  final ApiService _apiService = ApiService();
  final ImageController imageController = Get.put(ImageController());
  final PrayerTimesController _prayerTimesController =
      Get.put(PrayerTimesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(

        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        fit: StackFit.passthrough,
        children: [
          Scrollbar(
            radius: const Radius.circular(10),
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 270.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ayaoftheday(apiService: _apiService),
                    const SizedBox(
                      height: 15.0,
                    ),
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 130,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 5),
                        enlargeCenterPage: true,
                        enableInfiniteScroll: true,


                      ),
                      items:   [
                        const childactivitescontainer(),
                        PostureDetectionCarousel(top: 0,  bottom: 10),

                      ]
                    ),
                    const SizedBox(
                      height: 10,
                    ),


                    const SizedBox(
                      height: 10,
                    ),


                    const SizedBox(
                      height: 10,
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    Prayer_times(prayerTimesController: _prayerTimesController),




                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: MediaQuery.of(context).size.height / 3,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                image: DecorationImage(
                  alignment: Alignment.topCenter,
                  fit: BoxFit.fitWidth,
                  image: AssetImage(imageController.image.value),
                ),
              ),
              child: Obx(() {
                if (_prayerTimesController.prayerTimes.isNotEmpty) {
                  final currentPrayer = _prayerTimesController.prayerTimes.firstWhere(
                      (time) => time.time.isAfter(DateTime.now()),
                      orElse: () => _prayerTimesController.prayerTimes.first);
                  final nextPrayerIndex = _prayerTimesController.prayerTimes
                          .indexWhere((time) => time == currentPrayer) +
                      1;
                  final nextPrayer = nextPrayerIndex <
                          _prayerTimesController.prayerTimes.length
                      ? _prayerTimesController.prayerTimes[nextPrayerIndex]
                      : _prayerTimesController.prayerTimes.first;

                  return Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 60.0),
                    child: Row(
                      children: [
                        Container(
                          width: 165,
                          height: 120,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Colors.black.withOpacity(0.4),
                                Colors.black.withOpacity(0.6),
                              ],
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                              topRight: Radius.circular(50),
                            ),
                          ),
                          child:
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0, top: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('NOW',
                                    style: TextStyle(
                                        color: Colors.white70, fontSize: 10.0)),
                                Text(
                                  '${currentPrayer.name.capitalizeFirst}',
                                  style: const TextStyle(
                                      fontSize: 38.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                SizedBox(height: 5.0),
                                Text(
                                  'Next Prayer: ${nextPrayer.name.capitalizeFirst} at ${nextPrayer.time.toLocal().toIso8601String().substring(11, 16)}',
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontStyle: FontStyle.italic),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Lottie.asset('assets/animation/loading.json');
                }
              }),
            ),
          )
        ],
      ),
    );
  }
}



