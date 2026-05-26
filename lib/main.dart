import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

/// The main application widget for the Pokemon app.
///
/// This widget serves as the root of the application and provides
/// the material design scaffolding for the app.
class MainApp extends StatelessWidget {
  /// Creates a [MainApp] widget.
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Pokemon App'),
        ),
      ),
    );
  }
}
