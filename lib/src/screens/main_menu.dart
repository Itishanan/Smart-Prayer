
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:smartprayer/home/ayaoftheday/api_service.dart';
import 'package:smartprayer/src/controllers/home/image_controller_home.dart';
import 'package:smartprayer/src/data/repository/authentication_repository.dart';
import '../../home/ayaoftheday/aya_of_the_day_container.dart';
import '../controllers/prayertime_controller.dart';


class MainMenu extends StatelessWidget {
  MainMenu({super.key});

  final ApiService _apiService = ApiService();
  final ImageController imageController = Get.put(ImageController());
  final PrayerTimesController _prayerTimesController = Get.put(PrayerTimesController());

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
                if (_prayerTimesController.prayerTimes != null) {
                  final currentPrayer = _prayerTimesController.prayerTimes!.currentPrayer();
                  final nextPrayer = _prayerTimesController.prayerTimes!.nextPrayer();

                  return Padding(

                    padding: const EdgeInsets.only(left: 20.0, top: 60.0),
                    child: Row(

                      children: [
                        Container(
                        width: 160,
                        height: 130,

                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Colors.blue.withOpacity(0.1),
                                Colors.blue.withOpacity(0.4),
                              ],
                            ),

                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                              topRight: Radius.circular(50),
                            )
                          ),
                          child: Column(

                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('NOW', style: TextStyle(color: Colors.white70, fontSize: 10.0)),
                              Text(
                                '${currentPrayer.name.capitalizeFirst}',
                                style: TextStyle(fontSize: 38.0, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                              SizedBox(height: 5.0),
                              Text(
                                'Next Prayer: ${nextPrayer.name.capitalizeFirst} at ${_prayerTimesController.prayerTimes!.timeForPrayer(nextPrayer)?.toLocal().toIso8601String().substring(11, 16)}',
                                style: TextStyle(color: Colors.white70, fontStyle: FontStyle.italic),
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
