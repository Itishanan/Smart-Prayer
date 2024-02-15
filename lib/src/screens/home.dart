import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sliding_sheet2/sliding_sheet2.dart';

class myHome extends StatefulWidget {
  const myHome({Key? key}) : super(key: key);

  @override
  State<myHome> createState() => _myHomeState();
}

class _myHomeState extends State<myHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: PopupMenuButton(
          icon: Icon(Icons.menu),
          color: Colors.black,
          itemBuilder: (context) => [
            PopupMenuItem(
                child: TextButton(
              child: Text(
                'About Me',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.pushNamed(context, 'about');
              },
            ))
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SlidingSheet(
        elevation: 8,
        cornerRadius: 50,
        snapSpec: const SnapSpec(
          // Enable snapping. This is true by default.
          snap: true,
          // Set custom snapping points.
          snappings: [0.38, 0.7, 1.0],
          // Define to what the snappings relate to. In this case,
          // the total available space that the sheet can expand to.
          positioning: SnapPositioning.relativeToAvailableSpace,
        ),
        // The body widget will be displayed under the SlidingSheet
        // and a parallax effect can be applied to it.
        body: Container(
          child: Stack(
            children: [
              Container(
                child: ShaderMask(
                    shaderCallback: (rect) {
                      return const LinearGradient(
                              begin: Alignment.center,
                              end: Alignment.bottomCenter,
                              colors: [Colors.black, Colors.transparent])
                          .createShader(
                              Rect.fromLTRB(0, 0, rect.width, rect.height));
                    },
                    blendMode: BlendMode.dstIn,
                    child: Image.asset('assets/bg.png')),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.49),
                child: Column(
                  children: [
                    Text(
                      'Abdul Hanan',
                      style: TextStyle(
                          fontFamily: 'Soho',
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      "Flutter Developer",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        builder: (context, state) {
          // This is the content of the sheet that will get
          // scrolled, if the content is bigger than the available
          // height of the sheet.
          return Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
            height: 500,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    spec('6', ' Projects'),
                    spec('10', ' Clients'),
                    spec('32+', ' Messages'),
                  ],
                ),
                const SizedBox(height: 30),
                const Text(
                  "Specialized In",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 0),
                    Text(
                      "App Development",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        mySpec(Icons.android, 'Android'),
                        mySpec(FontAwesomeIcons.fire, 'Firebase'),
                        mySpec(FontAwesomeIcons.uikit, 'UI/UX'),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Eccomerece",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        mySpec(FontAwesomeIcons.shopify, 'Shopify'),
                        mySpec(FontAwesomeIcons.ship, 'Drop Shipping'),
                      ],
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Container mySpec(icon, tech) {
    return Container(
      width: 105,
      height: 115,
      child: Card(
        color: Color(0xff252525),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.white,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                tech,
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }

  spec(no, type) {
    return Row(
      children: [
        Text(
          no,
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Text(type),
        )
      ],
    );
  }
}
