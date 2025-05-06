import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user_model.dart';

class AuthService {
  final baseUrl = 'https://yourapi.com'; // Ganti dengan URL asli backend kamu

  Future<UserModel> login(String email, String password) async {
    final res = await http.post(
      Uri.parse('$baseUrl/login'),
      body: {'email': email, 'password': password},
    );
    if (res.statusCode == 200) {
      return UserModel.fromJson(json.decode(res.body));
    } else {
      throw Exception('Email atau password salah');
    }
  }

  Future<UserModel> register(String name, String email, String password) async {
    final res = await http.post(
      Uri.parse('$baseUrl/register'),
      body: {'name': name, 'email': email, 'password': password},
    );
    if (res.statusCode == 200) {
      return UserModel.fromJson(json.decode(res.body));
    } else {
      throw Exception('Registrasi gagal');
    }
  }
}
