import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key})
    : super(key: key); // Menambahkan key sebagai parameter

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Center(child: Text('Halaman Pengaturan')),
    );
  }
}
