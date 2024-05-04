import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:smartprayer/home/ayaoftheday/api_service.dart';
import 'package:smartprayer/home/ayaoftheday/aya_of_the_day.dart';
import 'package:smartprayer/src/common_widgets/login/divider.dart';
import 'package:smartprayer/src/controllers/home/image_controller_home.dart';
import 'package:smartprayer/src/controllers/prayertime_controller.dart';
import '../../home/ayaoftheday/aya_of_the_day_container.dart';
import '../data/repository/authentication_repository.dart';

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
        leading: PopupMenuButton(
          icon: const Icon(Iconsax.menu_14, color: Colors.white),
          color: Colors.black,
          itemBuilder: (context) => [
            PopupMenuItem(
              child: TextButton(
                child: const Text(
                  'Sign Out',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => AuthenticationRepository.instance.logout(),
              ),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        fit: StackFit.passthrough,
        children: [
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
                  final currentPrayer = _prayerTimesController.prayerTimes
                      .firstWhere((time) => time.time.isAfter(DateTime.now()),
                          orElse: () =>
                              _prayerTimesController.prayerTimes.last);
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
                          height: 100,
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
                      ],
                    ),
                  );
                } else {
                  return Lottie.asset('assets/animation/loading.json');
                }
              }),
            ),
          ),
          Positioned(
            top: 270,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ayaoftheday(apiService: _apiService),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 15,
                      height: 200,
                      decoration: const BoxDecoration(

                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(
                                217, 156, 156, 0.3803921568627451),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            bottomLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0),
                            topRight: Radius.circular(68.0)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 0, left: 12.0, right: 12.0, top: 12.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width - 15,
                            ),
                            child: Column(
                              children: [
                                Text("' Prayer Times '",
                                    style:
                                        Theme.of(context).textTheme.titleLarge),

                                const SizedBox(
                                  height: 8,
                                ),
                                Obx(() {
                                  return Column(
                                    children: _prayerTimesController.prayerTimes
                                        .map((time) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(time.name,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge),
                                            Text(
                                                time.time
                                                    .toLocal()
                                                    .toIso8601String()
                                                    .substring(11, 16),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium),

                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  );
                                }),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
