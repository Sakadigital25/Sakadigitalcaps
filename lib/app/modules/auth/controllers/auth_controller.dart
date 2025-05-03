import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AuthController extends GetxController {
  var isAuthenticated = false.obs; // Menyimpan status login
  var userEmail = ''.obs; // Menyimpan email pengguna yang sudah login
  final count = 0.obs; // Contoh untuk fungsi increment (bisa dihapus jika tidak dibutuhkan)

  @override
  void onInit() {
    super.onInit();
    // Mungkin ambil data auth dari penyimpanan lokal atau server saat inisialisasi
  }

  @override
  void onReady() {
    super.onReady();
    // Tempat untuk melakukan sesuatu setelah controller siap
  }

  @override
  void onClose() {
    super.onClose();
    // Tempat untuk membersihkan resource jika perlu
  }

  // Fungsi untuk login
  void login(String email, String password) {
    // Simulasi login, biasanya akan terhubung dengan API di sini
    if (email == 'admin@mail.com' && password == 'admin') {
      isAuthenticated.value = true;
      userEmail.value = email;
      Get.offAllNamed('/home'); // Setelah login berhasil, arahkan ke halaman home
    } else {
      Get.snackbar('Login Failed', 'Incorrect email or password');
    }
  }

  // Fungsi untuk logout
  void logout() {
    isAuthenticated.value = false;
    userEmail.value = '';
    Get.offAllNamed('/login'); // Arahkan kembali ke halaman login
  }

  // Fungsi untuk register (bisa sesuaikan dengan kebutuhan)
  void register(String email, String password) {
    // Simulasi register, biasanya terhubung dengan API
    Get.snackbar('Registration', 'Account created successfully for $email');
    Get.toNamed('/login'); // Setelah registrasi berhasil, arahkan ke halaman login
  }

  // Fungsi contoh untuk increment count
  void increment() => count.value++;
}
