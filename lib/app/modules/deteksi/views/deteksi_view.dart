import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeteksiView extends StatelessWidget {
  const DeteksiView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deteksi'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: const Center(
        child: Text('Halaman Deteksi', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
