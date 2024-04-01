import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:teste_app/src/entities/user.dart';
import 'dart:convert';

class AuthService {
  final _storage = const FlutterSecureStorage();
  final Dio _dio = Dio();

  Future<bool> login(String email, String password) async {
    try {
      final response = await _dio.post(
          'https://lychee-cookie-15918-17f2b39d104a.herokuapp.com/api/login',
          data: {
            'email': email,
            'password': password,
          });

      if (response.statusCode == 200 && response.data['token'] != null) {
        await _storage.write(key: 'token', value: response.data['token']);

        User user = User.fromJson(response.data['user']);
        await _storage.write(
            key: 'userData', value: json.encode(user.toJson()));

        _dio.options.headers['Authorization'] =
            'Bearer ${response.data['token']}';
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> register(
    String name,
    String email,
    String password,
  ) async {
    try {
      final response = await _dio.post(
        'https://lychee-cookie-15918-17f2b39d104a.herokuapp.com/api/register',
        data: {
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': password,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data['token'] != null) {
          await _storage.write(key: 'token', value: response.data['token']);

          User user = User.fromJson(response.data['user']);
          await _storage.write(
              key: 'userData', value: json.encode(user.toJson()));

          _dio.options.headers['Authorization'] =
              'Bearer ${response.data['token']}';
          return true;
        }

        return true;
      }

      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<User?> getUserData() async {
    String? userDataString = await _storage.read(key: 'userData');
    if (userDataString != null) {
      Map<String, dynamic> userDataMap = json.decode(userDataString);
      return User.fromJson(userDataMap);
    }
    return null;
  }

  Future<void> logout() async {
    try {
      // Remover o token de autenticação
      await _storage.delete(key: 'token');

      // Remover os dados do usuário
      await _storage.delete(key: 'userData');

      // Limpar os headers de autorização, se necessário
      _dio.options.headers['Authorization'] = null;
    } catch (e) {
      print(e);
    }
  }
}
