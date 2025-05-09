import 'package:get/get.dart';
import 'package:flutter/material.dart';

class RegisterController extends GetxController {
  var username = ''.obs;
  var password = ''.obs;

  void register() {
    if (username.value.isNotEmpty && password.value.isNotEmpty) {
      // Simulasi pendaftaran
      print('Mendaftar dengan username: ${username.value} dan password: ${password.value}');
      // Navigasi ke halaman setelah berhasil
      Get.offAll(HomeScreen());  // Redirect ke Home setelah berhasil daftar
    } else {
      // Tampilkan error jika ada input yang kosong
      Get.snackbar("Error", "Username dan Password tidak boleh kosong");
    }
  }
}
