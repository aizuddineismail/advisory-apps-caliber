import 'package:dio/dio.dart';

class HttpManager {
  static final HttpManager instance = HttpManager();

  Dio? _dio;

  Dio get client {
    if (_dio != null) {
      return _dio!;
    }

    return _dio = Dio();
  }
}
