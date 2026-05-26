import 'package:dio/dio.dart';
import 'package:pokemon_app/core/core.dart' show AppConstants;

class DioClient {
  DioClient() : _dio = _createDio();

  final Dio _dio;

  static Dio _createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
        headers: {'Content-Type': 'application/json'},
      ),
    );
    dio.interceptors.addAll([]);
    return dio;
  }

  Dio get dio => _dio;
}
