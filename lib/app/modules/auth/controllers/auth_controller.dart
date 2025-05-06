import 'package:get/get.dart';
import '../services/auth_service.dart';
import '../models/user_model.dart';

class AuthController extends GetxController {
  final authService = AuthService();
  var isLoading = false.obs;

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    try {
      final user = await authService.login(email, password);
      // TODO: Simpan token dan arahkan ke halaman utama
    } catch (e) {
      Get.snackbar("Login gagal", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register(String name, String email, String password) async {
    isLoading.value = true;
    try {
      final user = await authService.register(name, email, password);
      // TODO: Simpan token dan arahkan ke halaman utama
    } catch (e) {
      Get.snackbar("Registrasi gagal", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
