import 'package:advisory_rest_api/advisory_rest_api.dart';
import 'package:advisoryapps/authentication/authentication.dart';
import 'package:advisoryapps/home/home.dart';
import 'package:advisoryapps/l10n/l10n.dart';
import 'package:advisoryapps/singleton/singleton.dart';
import 'package:advisoryapps/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthenticationRestApi(
            client: HttpManager.instance.client,
            baseUrl: kBaseUrl,
          ),
        ),
        RepositoryProvider(
          create: (context) => ItemRestApi(
            client: HttpManager.instance.client,
            baseUrl: kBaseUrl,
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthenticationBloc(
              authenticationApi: context.read<AuthenticationRestApi>(),
            ),
            lazy: false,
          ),
          BlocProvider(
            create: (context) => ListItemBloc(
              itemApi: context.read<ItemRestApi>(),
              authenticationBloc: context.read<AuthenticationBloc>(),
            ),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData(
            appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
            colorScheme: ColorScheme.fromSwatch(
              accentColor: const Color(0xFF13B9FF),
            ),
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const AuthenticationGate(),
        ),
      ),
    );
  }
}
