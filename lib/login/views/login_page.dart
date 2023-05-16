import 'package:advisoryapps/authentication/authentication.dart';
import 'package:advisoryapps/utils/form_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  final email = TextEditingController();
  final password = TextEditingController();

  void submit() {
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });

    final form = _key.currentState;

    if (form == null || !form.validate()) {
      return;
    }

    context.read<AuthenticationBloc>().add(
          SubmitLoginForm(
            email: email.text,
            password: password.text,
          ),
        );

    form.save();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state.status == AuthenticationStatus.error) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error.message)),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Login Page')),
        body: Center(
          child: Form(
            key: _key,
            autovalidateMode: _autovalidateMode,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  TextFormField(
                    controller: email,
                    decoration: const InputDecoration(label: Text('Email')),
                    // validator: FormValidator.requiredField,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: password,
                    obscureText: true,
                    decoration: const InputDecoration(label: Text('Password')),
                    // validator: FormValidator.requiredField,
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<AuthenticationBloc, AuthenticationState>(
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: state.status != AuthenticationStatus.loading
                            ? submit
                            : null,
                        child: const Text('Login'),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
