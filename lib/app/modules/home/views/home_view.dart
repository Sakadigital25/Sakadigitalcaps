  import 'package:flutter/material.dart';
  import 'package:get/get.dart';
  import 'package:flutter_icons/flutter_icons.dart'; // Using flutter_icons instead of lucide_icons

  import '../controllers/home_controller.dart';

  class HomeView extends GetView<HomeController> {
    const HomeView({super.key});

    @override
    Widget build(BuildContext context) {
      final pages = <Widget>[
        const PostinganPage(),
        const PembelajaranPage(),
        const PengaturanPage(),
      ];

      return Obx(() {
        return Scaffold(
          body: SafeArea(child: pages[controller.selectedIndex.value]),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.selectedIndex.value,
            onTap: controller.changeTab,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(LucideIcons.home),
                label: 'Postingan',
              ),
              BottomNavigationBarItem(
                icon: Icon(LucideIcons.bookOpen),
                label: 'Pembelajaran',
              ),
              BottomNavigationBarItem(
                icon: Icon(LucideIcons.settings),
                label: 'Pengaturan',
              ),
            ],
          ),
          // Floating action button untuk menambahkan postingan
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (context) => const UploadPostBottomSheet(),
              );
            },
            backgroundColor: Colors.brown,
            child: const Icon(Icons.add),
          ),
        );
      });
    }
  }

  class PostinganPage extends StatelessWidget {
    const PostinganPage({super.key});

    @override
    Widget build(BuildContext context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: teks di kiri, avatar di kanan
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Text(
                  'SAKADIGITAL',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                    decoration: TextDecoration.underline,
                  ),
                ),
                const Spacer(),
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Color(0xFF4D4D4D),
                  child: Text(
                    'FOTO\nPROFILE',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Daftar postingan
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 3,
              itemBuilder: (context, index) {
                return Container(
                  height: 120,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    border: Border.all(color: Colors.brown),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: const Text('Post Kosong'),
                );
              },
            ),
          ),
        ],
      );
    }
  }

  class PembelajaranPage extends StatelessWidget {
    const PembelajaranPage({super.key});

    @override
    Widget build(BuildContext context) {
      return const Center(
        child: Text(
          'Halaman Buku Saku Digital',
          style: TextStyle(fontSize: 18),
        ),
      );
    }
  }

  class PengaturanPage extends StatelessWidget {
    const PengaturanPage({super.key});

    @override
    Widget build(BuildContext context) {
      return const Center(
        child: Text(
          'Halaman Pengaturan',
          style: TextStyle(fontSize: 18),
        ),
      );
    }
  }

  class UploadPostBottomSheet extends StatelessWidget {
    const UploadPostBottomSheet({super.key});

    @override
    Widget build(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Judul "Tambah Postingan"
            const Text(
              "Tambah Postingan",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.brown,  // Ganti warna teks menjadi coklat
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: "Tulis deskripsi...",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                hintStyle: TextStyle(color: Colors.grey),  // Untuk hint text
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () {
                // Tambahkan aksi upload gambar nanti
              },
              icon: const Icon(Icons.image),
              label: const Text("Pilih Gambar"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown,
                foregroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Aksi simpan postingan nanti
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                ),
                child: const Text(
                  "Posting",
                  style: TextStyle(
                    color: Colors.white
                  ),
                  ),
              ),
            )
          ],
        ),
      );
    }
  }
