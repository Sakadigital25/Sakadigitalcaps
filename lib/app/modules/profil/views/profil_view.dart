import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import '../../login/controllers/auth_controller.dart';

class ProfilView extends StatefulWidget {
  const ProfilView({Key? key}) : super(key: key);

  @override
  State<ProfilView> createState() => _ProfilViewState();
}

class _ProfilViewState extends State<ProfilView> {
  final authController = Get.find<AuthController>();
  bool isEditing = false;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController schoolController;
  String role = 'Penggalang';
  dynamic profilePic;
  File? localProfilePic;
  Uint8List? webProfilePicBytes;

  @override
  void initState() {
    super.initState();
    final user = authController.user.value;
    nameController = TextEditingController(text: user?['name'] ?? '');
    emailController = TextEditingController(text: user?['email'] ?? '');
    schoolController = TextEditingController(text: user?['school'] ?? '');
    role = user?['role'] ?? 'Penggalang';
    profilePic = user?['profilePic'];
    // Restore image state for web/mobile
    if (profilePic is Map && profilePic['type'] == 'bytes') {
      webProfilePicBytes = profilePic['data'];
    } else if (profilePic is Map && profilePic['type'] == 'file') {
      localProfilePic = File(profilePic['data']);
    } else if (profilePic is String && profilePic.isNotEmpty && !kIsWeb) {
      localProfilePic = File(profilePic);
    }
  }

  void startEdit() {
    setState(() => isEditing = true);
  }

  void cancelEdit() async {
    final confirm = await _showConfirmDialog(
        'Batalkan perubahan?', 'Perubahan yang belum disimpan akan hilang.');
    if (confirm) {
      final user = authController.user.value;
      setState(() {
        isEditing = false;
        nameController.text = user?['name'] ?? '';
        emailController.text = user?['email'] ?? '';
        schoolController.text = user?['school'] ?? '';
        role = user?['role'] ?? 'Penggalang';
        profilePic = user?['profilePic'];
        localProfilePic = null;
        webProfilePicBytes = null;
        if (profilePic is Map && profilePic['type'] == 'bytes') {
          webProfilePicBytes = profilePic['data'];
        } else if (profilePic is Map && profilePic['type'] == 'file') {
          localProfilePic = File(profilePic['data']);
        } else if (profilePic is String && profilePic.isNotEmpty && !kIsWeb) {
          localProfilePic = File(profilePic);
        }
      });
    }
  }

  void saveEdit() async {
    if (nameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        schoolController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Semua field harus diisi',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
    if (!GetUtils.isEmail(emailController.text.trim())) {
      Get.snackbar('Error', 'Format email tidak valid',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
    final confirm = await _showConfirmDialog(
        'Simpan perubahan?', 'Perubahan profil akan disimpan.');
    if (confirm) {
      dynamic picToSave;
      if (kIsWeb && webProfilePicBytes != null) {
        picToSave = {'type': 'bytes', 'data': webProfilePicBytes};
      } else if (!kIsWeb && localProfilePic != null) {
        picToSave = {'type': 'file', 'data': localProfilePic!.path};
      } else if (profilePic != null) {
        picToSave = profilePic;
      } else {
        picToSave = null;
      }
      authController.user.value = {
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'school': schoolController.text.trim(),
        'role': role,
        'profilePic': picToSave,
      };
      setState(() => isEditing = false);
      Get.snackbar('Berhasil', 'Profil berhasil diperbarui',
          backgroundColor: Colors.green, colorText: Colors.white);
    }
  }

  void logout() async {
    final confirm =
        await _showConfirmDialog('Logout?', 'Anda yakin ingin keluar?');
    if (confirm) {
      authController.logout();
    }
  }

  Future<bool> _showConfirmDialog(String title, String content) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Batal')),
              TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text('Ya')),
            ],
          ),
        ) ??
        false;
  }

  void pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      if (kIsWeb) {
        final bytes = await picked.readAsBytes();
        setState(() {
          webProfilePicBytes = bytes;
          localProfilePic = null;
        });
      } else {
        setState(() {
          localProfilePic = File(picked.path);
          webProfilePicBytes = null;
        });
      }
    }
  }

  void changePassword() async {
    await showDialog(
      context: context,
      builder: (context) => const _ChangePasswordDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider? profileImageProvider;
    if (kIsWeb && webProfilePicBytes != null) {
      profileImageProvider = MemoryImage(webProfilePicBytes!);
    } else if (!kIsWeb && localProfilePic != null) {
      profileImageProvider = FileImage(localProfilePic!);
    } else if (profilePic is Map &&
        profilePic['type'] == 'bytes' &&
        profilePic['data'] != null) {
      profileImageProvider = MemoryImage(profilePic['data']);
    } else if (profilePic is Map &&
        profilePic['type'] == 'file' &&
        profilePic['data'] != null &&
        !kIsWeb) {
      profileImageProvider = FileImage(File(profilePic['data']));
    } else if (profilePic is String &&
        profilePic.isNotEmpty &&
        !kIsWeb &&
        File(profilePic).existsSync()) {
      profileImageProvider = FileImage(File(profilePic));
    } else {
      profileImageProvider = null;
    }
    return Material(
      color: Colors.transparent,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: isEditing ? pickImage : null,
              child: CircleAvatar(
                radius: 48,
                backgroundColor: Colors.blue.shade100,
                backgroundImage: profileImageProvider,
                child: profileImageProvider == null
                    ? const Icon(Icons.person, size: 48, color: Colors.blue)
                    : null,
              ),
            ),
            const SizedBox(height: 16),
            isEditing
                ? TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Nama'),
                  )
                : Text(nameController.text,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            isEditing
                ? TextField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                  )
                : Text(emailController.text,
                    style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            isEditing
                ? TextField(
                    controller: schoolController,
                    decoration: const InputDecoration(labelText: 'Sekolah'),
                  )
                : Text(schoolController.text,
                    style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            isEditing
                ? DropdownButtonFormField<String>(
                    value: role,
                    items: const [
                      DropdownMenuItem(value: 'Siaga', child: Text('Siaga')),
                      DropdownMenuItem(
                          value: 'Penggalang', child: Text('Penggalang')),
                      DropdownMenuItem(
                          value: 'Pandega', child: Text('Pandega')),
                    ],
                    onChanged: (val) =>
                        setState(() => role = val ?? 'Penggalang'),
                    decoration: const InputDecoration(labelText: 'Tingkatan'),
                  )
                : Text('Tingkatan: $role',
                    style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: changePassword,
                  icon: const Icon(Icons.lock),
                  label: const Text('Ganti Password'),
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.brown),
                ),
                const SizedBox(width: 16),
                if (!isEditing)
                  ElevatedButton.icon(
                    onPressed: startEdit,
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit'),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  ),
              ],
            ),
            if (isEditing)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: saveEdit,
                    child: const Text('Simpan'),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: cancelEdit,
                    child: const Text('Batal'),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  ),
                ],
              ),
            const SizedBox(height: 32),
            Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: logout,
            ),
          ],
        ),
      ),
    );
  }
}

class _ChangePasswordDialog extends StatefulWidget {
  const _ChangePasswordDialog();
  @override
  State<_ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<_ChangePasswordDialog> {
  final oldPassController = TextEditingController();
  final newPassController = TextEditingController();
  final confirmPassController = TextEditingController();
  bool isLoading = false;

  void savePassword() {
    final oldPass = oldPassController.text;
    final newPass = newPassController.text;
    final confirmPass = confirmPassController.text;
    if (oldPass.isEmpty || newPass.isEmpty || confirmPass.isEmpty) {
      Get.snackbar('Error', 'Semua field harus diisi',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
    if (newPass.length < 6) {
      Get.snackbar('Error', 'Password baru minimal 6 karakter',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
    if (newPass != confirmPass) {
      Get.snackbar('Error', 'Konfirmasi password tidak cocok',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
    // Simulate password change
    setState(() => isLoading = true);
    Future.delayed(const Duration(seconds: 1), () {
      setState(() => isLoading = false);
      Navigator.pop(context);
      Get.snackbar('Berhasil', 'Password berhasil diubah',
          backgroundColor: Colors.green, colorText: Colors.white);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Ganti Password'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: oldPassController,
            decoration: const InputDecoration(labelText: 'Password Lama'),
            obscureText: true,
          ),
          TextField(
            controller: newPassController,
            decoration: const InputDecoration(labelText: 'Password Baru'),
            obscureText: true,
          ),
          TextField(
            controller: confirmPassController,
            decoration: const InputDecoration(labelText: 'Konfirmasi Password'),
            obscureText: true,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
        ElevatedButton(
          onPressed: isLoading ? null : savePassword,
          child: isLoading
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2))
              : const Text('Simpan'),
        ),
      ],
    );
  }
}
