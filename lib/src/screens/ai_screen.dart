import 'package:flutter/material.dart';
import 'package:smartprayer/src/common_widgets/posturedetectcarousel.dart';

import '../common_widgets/childactivitescontainer.dart';
 class aiscreen extends StatelessWidget {
   const aiscreen({super.key});

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         centerTitle: true,
         title: const Text(
           'A.I',
           style: TextStyle(fontSize: 24),
         ),


       ),
       body: Padding(
         padding:  EdgeInsets.all(8.0),
         child: Column(
           children: [
            Padding(
              padding: EdgeInsets.only(left: 10, ),
              child: PostureDetectionCarousel(top: 0, bottom: 10,left: 220),

            ),
            Padding(
              padding: EdgeInsets.only(left: 10, top: 20,),
              child: childactivitescontainer(),

            ),
           ],
         ),
       ),
     );
   }
 }
