import 'package:flutter/material.dart';
import 'package:smartprayer/src/screens/Quran/quranlistview.dart';

class QuranScreen extends StatelessWidget {
  const QuranScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Quran',style: TextStyle(fontSize: 24,)),
      ) ,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.green,

                  borderRadius: BorderRadiusDirectional.circular(20)
                ),
                height: 160,
                width: MediaQuery.of(context).size.width-30,

              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: SizedBox(
                height: 40,
                child: ListView(
                  itemExtent: 80,

                  scrollDirection: Axis.horizontal,
                  children:  [
                    QuranTile(quranTile: 'SURAH',isSelected: true),
                    QuranTile(quranTile: 'PARA',isSelected: false),
                    QuranTile(quranTile: 'JUZ',isSelected: false),
                    QuranTile(quranTile: 'PAGE',isSelected: false),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 430,
              child: PageView(

                children: [
                  Container(
                    color: Colors.red,
                  ),
                  Container(
                    color: Colors.blue,
                  ),
                  Container(
                    color: Colors.green,
                  ),
                  Container(
                    color: Colors.yellow,
                  ),
                ],
              ),
            )


          ],
        ),
      ),
    );
  }
}
