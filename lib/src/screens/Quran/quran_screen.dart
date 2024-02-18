import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:smartprayer/src/screens/Quran/quranlistview.dart';
class QuranScreen extends StatelessWidget {
  final QuranController controller = Get.put(QuranController());

  @override
  Widget build(BuildContext context) {
    // Injecting PageController into GetX's dependency system
    final PageController pageController = Get.put(PageController());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Quran',
          style: TextStyle(fontSize: 24),
        ),
      ),
      body: SingleChildScrollView(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadiusDirectional.circular(20),
                ),
                height: 160,
                width: MediaQuery.of(context).size.width - 30,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 22.0),
              child: SizedBox(
                height: 50,
                child: ListView(
                  itemExtent: 80,
                  scrollDirection: Axis.horizontal,
                  children: [
                    buildQuranTile('SURAH', 0),
                    buildQuranTile('PARA', 1),
                    buildQuranTile('JUZ', 2),
                    buildQuranTile('PAGE', 3),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 430,
              child: PageView(
                controller: pageController,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index) {
                  controller.setPageIndex(index);
                },
                children: [
                  Container(color: Colors.white),
                  Container(color: Colors.blue),
                  Container(color: Colors.green),
                  Container(color: Colors.yellow),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildQuranTile(String tile, int index) {
    return GestureDetector(
      onTap: () {
        controller.setPageIndex(index);
        Get.find<PageController>().animateToPage(
          index,
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(() => Container(

          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color : controller.selectedIndex.value == index
                    ? Colors.grey.withOpacity(0.1)
                    : Colors.transparent,
              ),
            ],
            borderRadius: controller.selectedIndex.value == index
                ? const BorderRadius.only(topRight: Radius.circular(19.9),topLeft: Radius.circular(20))
                : null,
            border: Border(
              bottom: BorderSide(
                color: controller.selectedIndex.value == index
                    ? Colors.blue
                    : Colors.transparent,
                width: 1,
              ),
            )
          ),
          child: Center(
            child: Text(
              tile,
              style: TextStyle(
                fontSize: 16,
                color: controller.selectedIndex.value == index
                    ? Colors.blue
                    : Colors.grey,
              ),
            ),
          ),
        )),
      ),
    );
  }
}