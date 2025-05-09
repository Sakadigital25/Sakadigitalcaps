import 'package:flutter/material.dart';

class BelajarView extends StatelessWidget {
  const BelajarView({Key? key}) : super(key: key);  // Menambahkan key sebagai parameter

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Belajar'),
      ),
      body: Center(child: Text('Halaman Belajar')),
    );
  }
}
