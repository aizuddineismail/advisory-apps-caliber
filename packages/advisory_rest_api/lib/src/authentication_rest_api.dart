import 'dart:developer';

import 'package:advisory_api/advisory_api.dart';
import 'package:dio/dio.dart';

class AuthenticationRestApi extends AuthenticationApi {
  AuthenticationRestApi({
    required this.client,
    required this.baseUrl,
  });

  final Dio client;
  final String baseUrl;

  @override
  Future<Credential> logIn({
    required String email,
    required String password,
  }) async {
    try {
      final body = {
        'email': email,
        'password': password,
      };
      final uri = Uri(
        scheme: 'http',
        host: baseUrl,
        path: 'index.php/login',
      );

      final response = await client.postUri<Map<String, dynamic>>(
        uri,
        data: FormData.fromMap(body),
      );

      final data = response.data!;
      final status = data['status'] as Map<String, dynamic>;

      if (status['code'] == 400) {
        throw CustomError(
          statusCode: status['code'] as int,
          message: status['message'] as String,
        );
      }

      return Credential.fromJson(data);
    } on DioError catch (e) {
      throw CustomError(
        statusCode: e.response?.statusCode ?? 0,
        message: e.response?.statusMessage ?? 'Error',
      );
    } catch (e) {
      rethrow;
    }
  }
}
