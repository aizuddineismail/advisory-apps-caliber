part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class GetCredential extends AuthenticationEvent {}

class SubmitLoginForm extends AuthenticationEvent {
  SubmitLoginForm({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}

class LogOut extends AuthenticationEvent {}
