import 'package:clothiva_project/bindings/general_bindings.dart';
import 'package:clothiva_project/routes/app_routes.dart';
import 'package:clothiva_project/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './utils/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: CAppTheme.lightTheme,
      darkTheme: CAppTheme.darkTheme,
      initialBinding:
          GeneralBindings(), //Whenever the app runs, initiates the instances (Get.put)
      //Show Loader or Circular Progress Indicator until Auth Repo decide the right screen to show
      getPages: AppRoutes.screens,
      home: const Scaffold(
        backgroundColor: CColors.primary,
        body: Center(child: CircularProgressIndicator.adaptive()),
      ),
    );
  }
}
