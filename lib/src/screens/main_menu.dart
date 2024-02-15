import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smartprayer/home/ayaoftheday/api_service.dart';
import 'package:smartprayer/src/controllers/home/image_controller_home.dart';
import 'package:smartprayer/src/data/repository/authentication_repository.dart';
import '../../home/ayaoftheday/aya_of_the_day_container.dart';

class MainMenu extends StatelessWidget {
  MainMenu({super.key});

  final ApiService _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    final ImageController imageController = Get.put(ImageController());
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: PopupMenuButton(
            icon: const Icon(Iconsax.menu_14,color: Colors.white,),
            color: Colors.black,
            itemBuilder: (context) => [
              PopupMenuItem(
                  child: TextButton(child: Text(
                      'Sign Out',
                      style: TextStyle(color: Colors.white),
                    ),

                    onPressed: ()=> AuthenticationRepository.instance.logout(),
                  ))
            ],
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,

          title: const Text(
            'Home',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Stack(
          fit: StackFit.passthrough,
          children: [
            Positioned(
              left: 0,
              right: 0,
              child: Obx(
                () => Container(
                    width: double.maxFinite,
                    height: MediaQuery.of(context).size.height / 3,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      image: DecorationImage(
                        alignment: Alignment.topCenter,
                        fit: BoxFit.fitWidth,
                        image: AssetImage(imageController.image.value),
                      ),
                    )),
              ),
            ),
            Positioned(
                top: 270,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: [
                      ayaoftheday(apiService: _apiService),
                      const SizedBox(
                        height: 10.0,
                      ),
                    ]),
                  ),
                ))
          ],
        ));
  }
}

