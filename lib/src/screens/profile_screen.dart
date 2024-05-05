import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smartprayer/src/common_widgets/childactivitescontainer.dart';
import 'package:smartprayer/src/data/repository/authentication_repository.dart';

import '../common_widgets/posturedetectcarousel.dart';

class ProfileScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.blue,
                    Colors.blue.withOpacity(0.4),
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
                    child:Text(
                      'Name: ${_auth.currentUser?.displayName ?? 'Anonymous'}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    )
                  ),
                  Positioned(
                    top: 50,
                    left: 10,
                    child: SizedBox(
                      height: 150,
                      child:
                      Text(
                        '''Email: ${_auth.currentUser?.email}''',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,

                        ),
                      ),
                    ),
                  ),
                  /*Positioned(
                    top: 80,
                    left: 10,
                    child: SizedBox(
                      height: 150,
                      child: Text(
                        'Phone No: ${_auth.currentUser?. }',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),*/

                    Positioned(
                    bottom: 40,

                    right: 0,
                    child: SizedBox(
                      height: 50,
                      child: IconButton(
                        icon: const Icon(
                          Iconsax.edit,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          // Navigator.of(context).pushNamed('/edit-profile');
                          Navigator.of(context).pushNamed('/edit-profile');
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 50),
          CarouselSlider(
              options: CarouselOptions(
                height: 130,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 5),
                enlargeCenterPage: true,
                enableInfiniteScroll: true,


              ),
              items:   const [
                childactivitescontainer(),
                PostureDetectionCarousel(top: 0,  bottom: 10),

              ]
          ),
          const SizedBox(height: 150),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(

                onPressed: () async {
                  AuthenticationRepository.instance.logout();
                },
                child: const Text('Sign Out',style: TextStyle(color: Colors.white,fontSize: 16),),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
