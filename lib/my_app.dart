import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/l10n/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todo_app/providers/remote_config_provider.dart';
import 'package:todo_app/utils/style/app_themes.dart';

import 'navigation/app_navigation.dart';
import 'navigation/route_information_parser.dart';
import 'navigation/router_delegate.dart';

final navigationProvider = Provider<AppNavigation>((ref) {
  return ref.watch<AppNavigation>(_appRouterDelegateProvider);
});

final _appRouterDelegateProvider =
    Provider<AppRouterDelegate>((ref) => AppRouterDelegate(ref));

class MyApp extends ConsumerWidget {
  MyApp({super.key});
  final _routeInformationParser = AppRouteInformationParser();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final redColor = ref.watch(remoteConfigProvider).redColor;

    return MaterialApp.router(
        // initialRoute: NavigationRouteName.home,
        // navigatorObservers: [NavigationLogger()],
        routeInformationParser: _routeInformationParser,
        routerDelegate:
            ref.watch<AppRouterDelegate>(_appRouterDelegateProvider),
        debugShowCheckedModeBanner: false,
        title: 'Todo App',
        supportedLocales: L10n.all,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        darkTheme: AppTheme.getDarkThemeWithRedColor(redColor),
        theme: AppTheme.getLightThemeWithRedColor(redColor));
  }
}
