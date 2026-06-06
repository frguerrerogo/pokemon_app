import 'package:flutter/material.dart';
import 'package:pokemon_app/app.dart';
import 'package:pokemon_app/app/app.dart' show AppRoutes;
import 'package:pokemon_app/core/core.dart' show FirebaseService, HiveService;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseService.initialize();
  await HiveService.initialize();

  final hasSession = HiveService.hasActiveSession();

  runApp(App(initialRoute: hasSession ? AppRoutes.home : AppRoutes.login));
}
