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
  var selectedTingkatan = ''.obs;

  var provinsi = <String>[].obs;
  var kota = <String>[].obs;
  var tingkatan = ["Siaga", "Penggalang", "Penegak","Pandega"].obs;

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
          for (var item in data) item['nama']: item['id'],
        };

        print("Provinsi berhasil dimuat");
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
      print("🔁 Mengambil kota dari: $url");

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

  void onKotaSelected(String kotaSelected) {
    selectedKota.value = kotaSelected;
  }

  void registerUser() {
    print("DATA TERDAFTAR");
    print("Nama: ${nameController.text}");
    print("Email: ${emailController.text}");
    print("Provinsi: ${selectedProvinsi.value}");
    print("Kota: ${selectedKota.value}");
    print("Sekolah: ${schoolController.text}");
    print("Tingkatan: ${selectedTingkatan.value}");
  }
}
