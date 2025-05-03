import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final schoolController = TextEditingController();

  var selectedProvinsi = ''.obs;
  var selectedKota = ''.obs;
  var selectedRole = ''.obs;

  var provinsi = <String>[].obs;
  var kota = <String>[].obs;
  var role = ["Siaga", "Penggalang", "Penegak", "Pandega"].obs;

  Map<String, String> provinsiMap = {};

  @override
  void onInit() {
    super.onInit();
    fetchProvinsi();
  }

  Future<void> fetchProvinsi() async {
    try {
      final response = await http.get(Uri.parse('https://ibnux.github.io/data-indonesia/provinsi.json'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        provinsi.value = List<String>.from(data.map((item) => item['nama']));
        provinsiMap = {
          for (var item in data) item['nama']: item['id'].toString(), // ID diubah jadi string
        };

        print("Provinsi berhasil dimuat: ${provinsi.value}");
      } else {
        print("Gagal mengambil data provinsi");
      }
    } catch (e) {
      print("Error fetchProvinsi: $e");
    }
  }

  Future<void> onProvinsiSelected(String prov) async {
    selectedProvinsi.value = prov;
    selectedKota.value = '';
    kota.clear();
    await fetchKota(provinsiMap[prov]!);
  }

  Future<void> fetchKota(String idProvinsi) async {
    try {
       final url = 'https://ibnux.github.io/data-indonesia/kabupaten/$idProvinsi.json';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        kota.value = List<String>.from(data.map((item) => item['nama']));
        print("Kota berhasil dimuat: ${kota.length}");
      } else {
        print("Gagal mengambil data kota dari API ibnux");
      }
    } catch (e) {
      print("Error fetchKota: $e");
    }
  }

  // Fungsi untuk menangani pemilihan kota
  void onKotaSelected(String kotaSelected) {
    selectedKota.value = kotaSelected;
  }

  // Fungsi untuk registrasi
 Future<void> registerUser() async {
  final name = nameController.text;
  final email = emailController.text;
  final school = schoolController.text;
  final provinsi = selectedProvinsi.value;
  final kota = selectedKota.value;
  final role = selectedRole.value;

  // Debugging: Cek nilai yang dikirim ke backend
  print("Name: $name, Email: $email, School: $school, Provinsi: $provinsi, Kota: $kota, Role: $role");

  // Validasi jika ada data yang kosong
  if (name.isEmpty || email.isEmpty || school.isEmpty || provinsi.isEmpty || kota.isEmpty || role.isEmpty) {
    Get.snackbar('Error', 'Semua field harus diisi!');
    return;
  }

  try {
    final response = await http.post(
      Uri.parse('http://localhost:5000/api/auth/register'),  // Ganti dengan URL server kamu
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': name,
        'email': email,
        'school': school,
        'provinsi': provinsi,  // Pastikan ini string, bukan number
        'kota': kota,          // Pastikan ini string, bukan number
        'role': role,          // Pastikan ini string
      }),
    );

    if (response.statusCode == 201) {
      Get.snackbar('Berhasil', 'Akun berhasil didaftarkan!');
      Future.delayed(Duration(seconds: 2), () {
        Get.toNamed('/login');
      });
    } else {
      final errorMessage = json.decode(response.body)['message'];
      Get.snackbar('Error', errorMessage);
    }
  } catch (error) {
    Get.snackbar('Error', 'Terjadi kesalahan saat mendaftar. $error');
  }
 }
}