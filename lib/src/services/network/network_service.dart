import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class NetworkService {
  late Dio _dio;
  final _storage = const FlutterSecureStorage();
  final _baseUrl = "https://lychee-cookie-15918-17f2b39d104a.herokuapp.com/api";

  NetworkService() {
    _dio = Dio(BaseOptions(baseUrl: _baseUrl));

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          String? token = await _storage.read(key: 'token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
    );
  }

  Dio get dio => _dio;
}
