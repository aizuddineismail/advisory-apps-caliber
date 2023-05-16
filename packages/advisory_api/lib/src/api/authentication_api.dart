import 'package:advisory_api/src/models/models.dart';

abstract class AuthenticationApi {
  Future<Credential> logIn({
    required String email,
    required String password,
  });
}
