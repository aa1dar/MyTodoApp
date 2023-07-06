import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/l10n/l10n.dart';
import 'package:todo_app/navigation/route_information_parser.dart';
import 'package:todo_app/navigation/router_delegate.dart';
import 'package:todo_app/providers/logger_provider.dart';
import 'package:todo_app/utils/style/app_themes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(ProviderScope(observers: [LoggerProvider()], child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _routerDeleage = AppRouterDelegate();
  final _routeInformationParser = AppRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        // initialRoute: NavigationRouteName.home,
        // navigatorObservers: [NavigationLogger()],
        routeInformationParser: _routeInformationParser,
        routerDelegate: _routerDeleage,
        debugShowCheckedModeBanner: false,
        title: 'Todo App',
        supportedLocales: L10n.all,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        darkTheme: AppTheme.darkTheme(),
        theme: AppTheme.lightTheme());
  }
}
