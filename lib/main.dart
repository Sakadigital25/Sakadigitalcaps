// main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'app/modules/login/controllers/auth_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize auth controller
    final authController = Get.put(AuthController());

    // Check login status when app starts
    authController.checkLoginStatus();

    return GetMaterialApp(
      title: "Saka Digital",
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.splash,
      getPages: AppPages.routes,
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
    );
  }
}
