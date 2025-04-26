import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Lengkapi Data Di Bawah",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown[800],
                  ),
                ),
              ),
              const SizedBox(height: 25),

              _textField(controller.nameController, "Nama Lengkap"),
              const SizedBox(height: 15),

              _textField(controller.emailController, "Alamat Email"),
              const SizedBox(height: 15),

              Obx(() => DropdownButtonFormField<String>(
                    value: controller.selectedProvinsi.value.isEmpty
                        ? null
                        : controller.selectedProvinsi.value,
                    items: controller.provinsi
                        .map((prov) => DropdownMenuItem(
                              value: prov,
                              child: Text(prov),
                            ))
                        .toList(),
                    onChanged: (val) => controller.onProvinsiSelected(val!),
                    decoration: _dropdownDecoration("Provinsi"),
                  )),
              const SizedBox(height: 10),

              Obx(() => DropdownButtonFormField<String>(
                    value: controller.selectedKota.value.isEmpty
                        ? null
                        : controller.selectedKota.value,
                    items: controller.kota
                        .map((city) => DropdownMenuItem(
                              value: city,
                              child: Text(city),
                            ))
                        .toList(),
                    onChanged: (val) => controller.onKotaSelected(val!),
                    decoration: _dropdownDecoration("Kabupaten/Kota"),
                  )),
              const SizedBox(height: 15),

              _textField(controller.schoolController, "Nama Sekolah (Ketik Manual)"),
              const SizedBox(height: 15),

              Obx(() => DropdownButtonFormField<String>(
                    value: controller.selectedTingkatan.value.isEmpty
                        ? null
                        : controller.selectedTingkatan.value,
                    items: controller.tingkatan
                        .map((lvl) => DropdownMenuItem(
                              value: lvl,
                              child: Text(lvl),
                            ))
                        .toList(),
                    onChanged: (val) =>
                        controller.selectedTingkatan.value = val!,
                    decoration: _dropdownDecoration("Tingkatan"),
                  )),
              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: controller.registerUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'DAFTAR',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }

  InputDecoration _dropdownDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    );
  }
}
