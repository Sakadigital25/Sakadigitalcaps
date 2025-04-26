import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void loginUser() {
    final email = emailController.text;
    final password = passwordController.text;

    if (email == 'admin@mail.com' && password == 'admin') {
      Get.offAllNamed('/home');
    } else {
      Get.snackbar("Error", "Email atau password salah");
    }
  }
}
