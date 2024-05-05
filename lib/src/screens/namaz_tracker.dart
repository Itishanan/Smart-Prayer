import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartprayer/src/controllers/prayertime_controller.dart';
import 'package:table_calendar/table_calendar.dart';
import '../controllers/namaztracker_controller.dart';

class NamazTracker extends StatelessWidget {
  final PrayerController prayerController = Get.put(PrayerController());
  final PrayerTimesController prayerTimeController = Get.put(PrayerTimesController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Prayer Log',style: TextStyle(fontSize: 24,)),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TableCalendar(
                headerStyle: const HeaderStyle(formatButtonVisible: false,titleCentered: false,),

                focusedDay: prayerController.focusedDay.value,
                firstDay: DateTime.now().subtract(const Duration(days: 365)),
                lastDay: DateTime.now(),
                selectedDayPredicate: (day) {
                  return isSameDay(
                        prayerController.selectedDate.value,
                        day,
                      ) &&
                      isSameDay(
                        prayerController.focusedDay.value,
                        // assuming you want to compare with focusedDay
                        day,
                      );
                },
                onDaySelected: (selectedDay, focusedDay) async {
                  prayerController.setDate(selectedDay, focusedDay);
                  await prayerController.fetchPreviousPrayers(selectedDay);
                },
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        children: List.generate(
                          5,
                          (index) => Obx(() => CheckboxListTile(
                                title: Text(_getPrayerName(index)),
                                value: prayerController.previousPrayers[index],
                                onChanged: (value) {
                                  prayerController.togglePrayer(
                                      index, value ?? false);
                                  prayerController
                                      .savePrayers(); // Autosave on change

                                  // Check if all checkboxes for the previous day are checked
                                  if (prayerController.previousPrayers
                                      .every((completed) => completed)) {
                                    prayerController
                                        .completeActivity(); // Call completeActivity
                                  }
                                },
                              )),
                        ),
                      ),
                      SizedBox(height: 16),
                      Obx(() => Text(
                          'Streak: ${prayerController.streak.value} days')),
                      // Adjust spacing as needed
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  String _getPrayerName(int index) {
    switch (index) {
      case 0:
        return 'Fajr';
      case 1:
        return 'Zuhr';
      case 2:
        return 'Asr';
      case 3:
        return 'Maghrib';
      case 4:
        return 'Isha';
      default:
        return 'Unknown';
    }
  }
}
