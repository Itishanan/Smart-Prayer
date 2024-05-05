import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/prayertime_controller.dart';

class Prayer_times extends StatelessWidget {
  const Prayer_times({
    super.key,
    required PrayerTimesController prayerTimesController,
  }) : _prayerTimesController = prayerTimesController;

  final PrayerTimesController _prayerTimesController;

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Scrollbar(
        radius: const Radius.circular(100),
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
    );
  }
}