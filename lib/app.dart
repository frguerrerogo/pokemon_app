import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:pokemon_app/app/app.dart' show AppPages, InitialBinding;
import 'package:pokemon_app/core/core.dart' show AppTheme;
import 'package:pokemon_app/l10n/app_localizations.dart';

class App extends StatelessWidget {
  const App({required this.initialRoute, super.key});
  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Pokemon App',
      theme: AppTheme.light,
      themeMode: ThemeMode.dark,
      darkTheme: AppTheme.dark,
      initialRoute: initialRoute,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es'),
        Locale('en'),
      ],
      locale: const Locale('es'),
      initialBinding: InitialBinding(),
    );
  }
}
