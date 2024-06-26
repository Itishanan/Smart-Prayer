import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../features/ai/posturedetection.dart'; // Import Get package if not already imported

class PostureDetectionCarousel extends StatelessWidget {
  final double bottom;
  final double top;
  final double left;

  const PostureDetectionCarousel({
    Key? key,
    this.bottom = 10,
    this.top = 0,
    this.left = 160,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
            Colors.black,
            Colors.black.withOpacity(0.4),
          ],
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          topRight: Radius.circular(160),
        ),
      ),
      height: 140,
      width: MediaQuery.of(context).size.width - 30,
      child: Stack(
        children: [
          Positioned(
            top: 20,
            left: 10,
            child: Text(
              'Posture Detection',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 10,
            child: SizedBox(
              height: 150,
              child: Text(
                'For Namaz',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            top: 85,
            left: 10,
            child: SizedBox(
              width: 90,
              height: 35,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
                onPressed: () {
                  Get.to(() => PostureDetectionScreen());
                },
                child: const Text(
                  'Check Now',
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: bottom,
            top: top,
            left: left,
            child: SizedBox(
              height: 160,
              child: Image(
                image: AssetImage('assets/images/postureDetection.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
