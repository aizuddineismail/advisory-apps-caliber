part of 'authentication_bloc.dart';

enum AuthenticationStatus {
  initial,
  loading,
  completed,
  error,
}

class AuthenticationState extends Equatable {
  const AuthenticationState({
    required this.status,
    required this.credential,
    required this.error,
  });

  factory AuthenticationState.initial() {
    return AuthenticationState(
      status: AuthenticationStatus.initial,
      credential: Credential.initial(),
      error: CustomError.initial(),
    );
  }

  final AuthenticationStatus status;
  final Credential credential;
  final CustomError error;

  @override
  List<Object> get props => [status, credential, error];

  @override
  bool get stringify => true;

  AuthenticationState copyWith({
    AuthenticationStatus? status,
    Credential? credential,
    CustomError? error,
  }) {
    return AuthenticationState(
      status: status ?? this.status,
      credential: credential ?? this.credential,
      error: error ?? this.error,
    );
  }
}
