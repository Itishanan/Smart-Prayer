import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../controllers/onboarding_controller.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    return Scaffold(
      body: Stack(
        children: [
          // Onboarding Screens
          PageView(

            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              Onboardingpage(
                image: 'assets/images/onboarding/onbrd1.gif',
                title: 'Join us in a voyage to prayer perfection – your spiritual growth begins with the first tap.',
              ),
              Onboardingpage(
                image: 'assets/images/onboarding/onbrd5.gif',
                title: "With the wings of Dua and the shield of Sabr, we soar above adversity, unbroken and unwavering.",
              ),
              Onboardingpage(
                image: 'assets/images/onboarding/onbrd2.gif',
                title: 'In the pursuit of understanding Islam, knowledge becomes the vessel that carries us closer to the heart of faith.',
              ),
              Onboardingpage(
                image: 'assets/images/onboarding/onbrd4.gif',
                title: 'Encourage Islamic learning through exciting activities, transforming traditional teachings into fun and memorable experiences for children.',
              ),

            ],
          ),

          const OnBoardingSkip(),
          // Indicator
          Positioned(
            bottom: kBottomNavigationBarHeight + 25,
            left: 24,
            child: SmoothPageIndicator(
              controller: controller.pageController,
              onDotClicked: controller.dotNavigationClick,
              count: 4,
              effect: const ExpandingDotsEffect(
                activeDotColor: Colors.lightBlue,
                dotHeight: 6,
              ),
            ),
          ),

          Positioned(
            right: 24,
            bottom: kBottomNavigationBarHeight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                backgroundColor: Colors.lightBlue,
              ),
              onPressed: () => OnBoardingController.instance.nextPage(),
              child: const Icon(Icons.arrow_forward_rounded),
            ),
          ),
        ],
      ),
    );
  }
}

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: kToolbarHeight,
      right: 10,
      child: TextButton(
        onPressed: () => OnBoardingController.instance.skipPage(),
        child:  Text('Skip' , style: Theme.of(context).textTheme.titleSmall,),
      ),
    );
  }
}

class Onboardingpage extends StatelessWidget {
  const Onboardingpage({
    super.key,
    required this.image,
    required this.title,
  });

  final String image, title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedOpacity(
        duration: const Duration(seconds: 1), // Adjust the duration as needed
        opacity: 1.0, // Initial opacity
        onEnd: () {}, // Callback when the animation ends
        child: Column(
          children: [
            Image(
              width: MediaQuery.of(Get.context!).size.width * 0.8,
              height: MediaQuery.of(Get.context!).size.height * 0.6,
              image: AssetImage(image),
            ),

            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
