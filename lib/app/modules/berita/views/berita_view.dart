import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/berita_controller.dart';

class BeritaView extends GetView<BeritaController> {
  const BeritaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Berita')),
      body: const Center(child: Text('Halaman Berita')),
    );
  }
}