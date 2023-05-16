import 'package:advisory_api/advisory_api.dart';
import 'package:advisoryapps/singleton/singleton.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({required this.authenticationApi})
      : super(AuthenticationState.initial()) {
    on<SubmitLoginForm>(_onSubmitLoginForm);
    on<LogOut>(_onLogOut);
    on<GetCredential>(_onGetCredential);

    add(GetCredential());
  }

  final AuthenticationApi authenticationApi;

  Future<void> _onGetCredential(
    GetCredential event,
    Emitter<AuthenticationState> emit,
  ) async {
    final credential = await SecureStorage.instance.getCredential();

    emit(state.copyWith(credential: credential));
  }

  Future<void> _onSubmitLoginForm(
    SubmitLoginForm event,
    Emitter<AuthenticationState> emit,
  ) async {
    try {
      emit(state.copyWith(status: AuthenticationStatus.loading));

      final credential = await authenticationApi.logIn(
        email: event.email,
        password: event.password,
      );

      await SecureStorage.instance.storeToken(
        id: credential.id.toString(),
        token: credential.token,
      );

      emit(
        state.copyWith(
          status: AuthenticationStatus.completed,
          credential: credential,
        ),
      );
    } on CustomError catch (e) {
      emit(
        state.copyWith(
          status: AuthenticationStatus.error,
          error: e,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AuthenticationStatus.error,
          error: CustomError(
            statusCode: 0,
            message: 'Error logging in',
          ),
        ),
      );
    }
  }

  void _onLogOut(
    LogOut event,
    Emitter<AuthenticationState> emit,
  ) {
    SecureStorage.instance.deleteToken();
    emit(AuthenticationState.initial());
  }
}
