import 'package:advisoryapps/authentication/authentication.dart';
import 'package:advisoryapps/home/views/home_page.dart';
import 'package:advisoryapps/login/views/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationGate extends StatelessWidget {
  const AuthenticationGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return state.credential.token.isNotEmpty
            ? const HomePage()
            : const LoginPage();
      },
    );
  }
}
