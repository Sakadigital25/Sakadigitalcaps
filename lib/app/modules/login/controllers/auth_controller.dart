import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../routes/app_pages.dart';
import 'dart:convert';

class AuthController extends GetxController {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isLoading = false.obs;
  var isLoggedIn = false.obs;
  var user = Rxn<Map<String, dynamic>>();

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  // Simulate login with validation
  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text;
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        "Error",
        "Email dan Password tidak boleh kosong",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    if (!GetUtils.isEmail(email)) {
      Get.snackbar(
        "Error",
        "Format email tidak valid",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    if (password.length < 6) {
      Get.snackbar(
        "Error",
        "Password minimal 6 karakter",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));
    isLoggedIn.value = true;
    user.value = {
      'name': 'User',
      'email': email,
      'school': 'SMP 18 Kota Tegal',
      'role': 'Siaga',
      'profilePic': null,
    };
    isLoading.value = false;
    Get.offAllNamed(Routes.HOME);
    Get.snackbar(
      "Selamat datang",
      "Selamat datang $email!",
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  // Simulate logout
  void logout() {
    isLoggedIn.value = false;
    user.value = null;
    Get.offAllNamed(Routes.HOME);
  }

  // Simulate login status check
  void checkLoginStatus() {
    // No persistent storage, always start logged out
    isLoggedIn.value = false;
    user.value = null;
  }
}
