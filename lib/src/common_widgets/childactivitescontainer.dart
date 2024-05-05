import 'package:flutter/material.dart';


class childactivitescontainer extends StatelessWidget {
  const childactivitescontainer({
    super.key,
  });

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
      height: 140,
      width: MediaQuery.of(context).size.width - 30,
      child:  Stack(
        children: [
          Positioned(
            top: 20,
            left: 20,
            child: Text(
              'Explore Now',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,

              ),
            ),
          ),

          Positioned(
            top: 40,
            left: 20,
            child: Text(
              'Explore Activites',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            top: 65,
            left: 20,
            child: SizedBox(

              height: 150,
              child: Text(
                'For Children',
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
              width: 130,
              height: 35,
              child:TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
                onPressed: () {},
                child: const Text('Get Start'),

              ),
            ),
          ), Positioned(
            bottom: 0,
            right: 0,
            child: SizedBox(

              height: 150,
              child: Image(
                image: AssetImage('assets/images/childlearning.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
