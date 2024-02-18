import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:smartprayer/src/screens/Quran/quranlistview.dart';


import 'Surah/surah_view.dart';

class QuranScreen extends StatelessWidget {
  final QuranController controller = Get.put(QuranController());

  @override
  Widget build(BuildContext context) {
    // Injecting PageController into GetX's dependency system
    final PageController pageController = Get.put(PageController());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
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
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.blue.shade900,
                      Colors.blue.shade100,
                    ],
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    topRight: Radius.circular(160),
                  ),
                ),
                height: 160,
                width: MediaQuery.of(context).size.width - 30,
                child:  Stack(
                  children: [
                    Positioned(
                      top: 20,
                      left: 20,
                      child: Text(
                        'Last Read',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,

                        ),
                      ),
                    ),

                    Positioned(
                      top: 50,
                      left: 20,
                      child: Text(
                        'Surah Al-Fatiha',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 80,
                      left: 20,
                      child: SizedBox(

                        height: 150,
                        child: Text(
                          'Ayah No 3',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,

                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 110,
                      left: 20,
                      child: SizedBox(
                        width: 130,
                        height: 35,
                        child:TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () {},
                          child: const Text('Continue Reading'),

                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 40,
                      right: 0,
                      child: SizedBox(

                        height: 150,
                        child: Image(
                          image: AssetImage('assets/images/quran_screen.png'),
                        ),
                      ),
                    ),
                  ],
                ),
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
                  SurahView(),
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
          curve: Curves.fastOutSlowIn,
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(() => Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: controller.selectedIndex.value == index
                          ? Colors.grey.withOpacity(0.1)
                          : Colors.transparent,
                    ),
                  ],
                  borderRadius: controller.selectedIndex.value == index
                      ? const BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(9.90))
                      : null,
                  border: Border(
                    bottom: BorderSide(
                      color: controller.selectedIndex.value == index
                          ? Colors.blue
                          : Colors.transparent,
                      width: 1,
                    ),
                  )),
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
