import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:smartprayer/bindings/genral_bindings.dart';
import 'package:smartprayer/src/utils/Themes/theme.dart';
import 'package:smartprayer/src/utils/navigation_menu.dart';

import 'src/features/authentication/screens/onboarding/onboarding.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: GeneralBindings(),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home:  const Scaffold(

        backgroundColor: Colors.white,body: Center(child: CircularProgressIndicator(color: Colors.lightBlue,),),),

    );
  }
}