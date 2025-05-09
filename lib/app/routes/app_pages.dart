import 'package:get/get.dart';
import '../modules/login/views/login_view.dart';
import '../modules/home/views/home_screen.dart';
// Import modul yang benar
import '../modules/pembelajaran/views/pembelajaran_view.dart'; // Pastikan file ini ada
import '../modules/deteksi/views/deteksi_view.dart'; // Pastikan file ini ada
import '../modules/berita/views/berita_view.dart';
import '../modules/profil/views/profil_view.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/home/bindings/home_binding.dart';

class AppPages {
  static const splash = Routes.SPLASH;
  static const onboarding = Routes.ONBOARDING;
  static const initial = Routes.LOGIN;

  static final routes = [
    GetPage(name: Routes.SPLASH, page: () => SplashView()),
    GetPage(name: Routes.ONBOARDING, page: () => OnboardingView()),
    GetPage(name: Routes.LOGIN, page: () => LoginView()),
    GetPage(
      name: Routes.HOME,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
    // Tambahkan rute lain
    GetPage(
      name: Routes.PEMBELAJARAN,
      page: () => PembelajaranView(),
    ), // Pastikan kelas PembelajaranView ada
    GetPage(
      name: Routes.DETEKSI,
      page: () => DeteksiView(),
    ), // Pastikan kelas DeteksiView ada
    GetPage(name: Routes.BERITA, page: () => BeritaView()),
    GetPage(name: Routes.PROFIL, page: () => ProfilView()),
  ];
}

class Routes {
  static const SPLASH = '/splash';
  static const ONBOARDING = '/onboarding';
  static const LOGIN = '/login';
  static const HOME = '/home';
  static const PEMBELAJARAN = '/pembelajaran';
  static const DETEKSI = '/deteksi';
  static const BERITA = '/berita';
  static const PROFIL = '/profil';
}
