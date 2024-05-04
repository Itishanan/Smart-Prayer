import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../src/common_widgets/login/divider.dart';
import '../../src/constants/colors.dart';
import 'api_service.dart';
import 'aya_of_the_day.dart';

class ayaoftheday extends StatelessWidget {
  const ayaoftheday({
    super.key,
    required ApiService apiService,
  }) : _apiService = apiService;

  final ApiService _apiService;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AyaoftheDay>(
        future: _apiService.getAyaOfTheDay(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return  Lottie.asset('assets/animation/loading.json');
            case ConnectionState.waiting:
            case ConnectionState.active:
              return  Lottie.asset('assets/animation/loading.json');
            case ConnectionState.done:
              return Container(
                  width: MediaQuery.of(context).size.width - 15,
                  height: 200,
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(
                            217, 156, 156, 0.3803921568627451), // Shadow color
                        spreadRadius: 5, // Spread radius
                        blurRadius: 7, // Blur radius
                        offset: Offset(0, 3), // Offset (X, Y)
                      ),
                    ],
                    color: SColors.primaryBackground,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                        topRight: Radius.circular(68.0)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 0,left: 12.0,right: 12.0,top: 12.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width - 15,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 8,
                            ),
                            Text("' Ayyah of The Day '",
                                style: Theme.of(context).textTheme.titleLarge),
                            const login_divider(
                              dividerText: 'VERSE',
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(snapshot.data!.arText!,
                                style:
                                    Theme.of(context).textTheme.headlineSmall),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(snapshot.data!.enTran!,
                                style: Theme.of(context).textTheme.bodyMedium),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                          text: 'Surah No ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall),
                                      TextSpan(
                                          text: snapshot.data!.surNumber!
                                              .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                          text: 'Surah : ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall),
                                      TextSpan(
                                          text: snapshot.data!.surEnName!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ));
          }
        });
  }
}
