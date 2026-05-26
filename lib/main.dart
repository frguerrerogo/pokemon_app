import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:pokemon_app/app/app.dart' show AppPages, AppRoutes, FirebaseConfig;
import 'package:pokemon_app/core/core.dart' show AppTheme, HiveService;
import 'package:pokemon_app/l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseConfig.initialize();
  await HiveService.init();

  final hasSession = HiveService.hasActiveSession();

  runApp(MyApp(initialRoute: hasSession ? AppRoutes.home : AppRoutes.login));
}

class MyApp extends StatelessWidget {
  const MyApp({required this.initialRoute, super.key});
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
    );
  }
}
