import 'dart:io';

void runInit() {
  print('Initializing project...');

  // create DI
  File('lib/core/di/injection.dart')
    ..createSync(recursive: true)
    ..writeAsStringSync('''
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupDI() {
  // @mycli-di-insert
}
''');

  // modify main.dart
  final mainFile = File('lib/main.dart');
  if (!mainFile.existsSync()) {
    print('main.dart not found');
    return;
  }

  mainFile.writeAsStringSync('''
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/di/injection.dart';

void main() {
  setupDI();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // @mycli-provider-insert
      ],
      child: MaterialApp(
        home: const Scaffold(),
      ),
    );
  }
}
''');

  print('Init completed');
}
