import 'package:get/get.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/berita/bindings/berita_binding.dart';
import '../modules/berita/views/berita_view.dart';
import '../modules/pembelajaran/bindings/pembelajaran_binding.dart';
import '../modules/pembelajaran/views/pembelajaran_view.dart';
import '../modules/deteksi/bindings/deteksi_binding.dart';
import '../modules/deteksi/views/deteksi_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/daftar/bindings/daftar_binding.dart';
import '../modules/daftar/views/daftar_view.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = AppRoutes.home;

  static final routes = [
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.berita,
      page: () => const BeritaView(),
      binding: BeritaBinding(),
    ),
    GetPage(
      name: AppRoutes.pembelajaran,
      page: () => const PembelajaranView(),
      binding: PembelajaranBinding(),
    ),
    GetPage(
      name: AppRoutes.deteksi,
      page: () => const DeteksiView(),
      binding: DeteksiBinding(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.daftar,
      page: () => const DaftarView(),
      binding: DaftarBinding(),
    ),
  ];
}