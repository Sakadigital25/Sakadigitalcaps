import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../../../modules/pembelajaran/views/pembelajaran_view.dart';
import '../../../modules/berita/views/berita_view.dart';
import '../../../modules/profil/views/profil_view.dart';
import 'package:sakadigitalcaps/shared/widgets/main_navigation_scaffold.dart';
import '../../login/controllers/auth_controller.dart';
import 'dart:io';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainNavigationScaffold(
      body: _HomeDashboard(),
    );
  }
}

class _HomeDashboard extends StatelessWidget {
  final List<Map<String, String>> beritaList = const [
    {
      'title': 'Pramuka SMP 18 kota tegal melakukan camping di bumijawa.',
      'content':
          'Kegiatan camping diikuti oleh seluruh anggota pramuka SMP 18 Tegal...'
    },
    {
      'title': 'SMP 18 Tegal mendapatkan juara 1 dalam lomba semaphore.',
      'content':
          'Tim pramuka SMP 18 Tegal berhasil meraih juara 1 dalam lomba semaphore tingkat kota...'
    },
    {
      'title': 'Kegiatan bakti sosial pramuka di desa Margasari.',
      'content':
          'Anggota pramuka melakukan bakti sosial dengan membagikan sembako...'
    },
    // Add more sample news if needed
  ];

  final List<Map<String, dynamic>> progressList = const [
    {'label': 'Pembelajaran Selesai', 'value': 5, 'total': 10},
    {'label': 'Berita Dibaca', 'value': 7, 'total': 20},
    {'label': 'Lencana', 'value': 2, 'total': 5},
  ];

  _HomeDashboard({Key? key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final user = authController.user.value;
    final String name = user?['name'] ?? '';
    final dynamic profilePic = user?['profilePic'];
    ImageProvider? profileImageProvider;
    if (profilePic is Map &&
        profilePic['type'] == 'bytes' &&
        profilePic['data'] != null) {
      profileImageProvider = MemoryImage(profilePic['data']);
    } else if (profilePic is Map &&
        profilePic['type'] == 'file' &&
        profilePic['data'] != null) {
      profileImageProvider = FileImage(File(profilePic['data']));
    } else if (profilePic is String &&
        profilePic.isNotEmpty &&
        !GetPlatform.isWeb &&
        File(profilePic).existsSync()) {
      profileImageProvider = FileImage(File(profilePic));
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                const Text(
                  'Saka Digital',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown),
                ),
                const Spacer(),
                if (name.isNotEmpty)
                  GestureDetector(
                    onTap: () => Get.toNamed('/profil'),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.blue.shade100,
                          backgroundImage: profileImageProvider,
                          child: profileImageProvider == null
                              ? const Icon(Icons.person, color: Colors.blue)
                              : null,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          name,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.brown),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          // Greeting Card
          Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.blue.shade200, Colors.blue.shade50]),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.shade100.withOpacity(0.5),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.blue.shade100,
                  backgroundImage: profileImageProvider,
                  child: profileImageProvider == null
                      ? const Icon(Icons.person, size: 32, color: Colors.blue)
                      : null,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name.isNotEmpty
                            ? 'Selamat datang, $name!'
                            : 'Selamat datang di Saka Digital!',
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown),
                      ),
                      if (name.isEmpty)
                        TextButton(
                          onPressed: () => Get.toNamed('/login'),
                          child: const Text('Masuk untuk mengakses fitur'),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Dashboard Cards
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _dashboardCard(
                    context, 'Pembelajaran', Icons.school, '/pembelajaran'),
                _dashboardCard(context, 'Berita', Icons.article, '/berita'),
                _dashboardCard(
                    context, 'Deteksi', Icons.camera_alt, '/deteksi'),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Progress/Statistics
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Progress',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown)),
                const SizedBox(height: 12),
                ...progressList
                    .map((item) => _progressBar(
                        item['label'], item['value'], item['total']))
                    .toList(),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Recent News
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Berita Terbaru',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown)),
                TextButton(
                  onPressed: () => Get.toNamed('/berita'),
                  child: const Text('See All'),
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: beritaList.length > 3 ? 3 : beritaList.length,
            itemBuilder: (context, i) => _beritaCard(context, beritaList[i]),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _dashboardCard(
      BuildContext context, String title, IconData icon, String route) {
    return GestureDetector(
      onTap: () => Get.toNamed(route),
      child: Container(
        width: 100,
        height: 100,
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.shade100.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 36, color: Colors.blue),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Widget _progressBar(String label, int value, int total) {
    final percent = total > 0 ? value / total : 0.0;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 4),
          Stack(
            children: [
              Container(
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              Container(
                height: 12,
                width: 200 * percent,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.blue, Colors.lightBlueAccent]),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ],
          ),
          Text('$value / $total',
              style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _beritaCard(BuildContext context, Map<String, String> berita) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        title: Text(berita['title'] ?? '',
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(berita['content'] ?? '',
            maxLines: 2, overflow: TextOverflow.ellipsis),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // Show detail page (to be implemented)
          Get.snackbar('Detail Berita', berita['title'] ?? '',
              snackPosition: SnackPosition.BOTTOM);
        },
      ),
    );
  }
}
