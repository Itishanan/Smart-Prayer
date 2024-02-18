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
                  child: TextButton(child: const Text(
                      'Sign Out',
                      style: TextStyle(color: Colors.white),
                    ),

                    onPressed: ()=> AuthenticationRepository.instance.logout(),
                  ))
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
                    ),
                  child:  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0,top: 60.0),
                        child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                            height: 123.0,
                              width: 180.0,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8.0),
                                    bottomLeft: Radius.circular(20.0),
                                    bottomRight: Radius.circular(20.0),
                                    topRight: Radius.circular(160.0)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromRGBO(
                                        05, 0, 0, 0.30), // Shadow color
                                    spreadRadius: 5, // Spread radius
                                    blurRadius: 7, // Blur radius
                                    offset: Offset(0, 3), // Offset (X, Y)
                                  ),
                                ],
                              ),
                            child:  Column(

                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('NOW',style: TextStyle(color: Colors.grey),),
                                Text('Fajar',style: TextStyle(fontSize: 38.0,fontWeight: FontWeight.bold,color: Colors.white)),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Text('Upcomming  Prayer is Zuhr at 1.30 ',style: TextStyle(color: Colors.white,fontStyle: FontStyle.italic),),
                              ],
                            ),
                            ),

                          ],
                        ),
                      ),



                    ],
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

