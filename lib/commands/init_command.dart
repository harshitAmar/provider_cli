import 'dart:io';

void runInit() {
  print('🚀 Initializing project...\n');

  final root = Directory.current.path;

  /// =========================
  /// Ask for routing
  /// =========================

  stdout.write('Do you want to setup named routing? (y/n): ');

  final enableRouting = stdin.readLineSync()?.trim().toLowerCase() == 'y';

  String routeType = '';

  if (enableRouting) {
    print('\nSelect routing type:');
    print('1. GoRouter');
    print('2. Flutter Default Navigator');

    stdout.write('\nEnter option (1/2): ');

    final routeInput = stdin.readLineSync()?.trim();

    if (routeInput == '1') {
      routeType = 'gorouter';
    } else {
      routeType = 'default';
    }
  }

  /// =========================
  /// Add packages
  /// =========================

  print('\n📦 Adding dependencies...');

  Process.runSync(
    'flutter',
    ['pub', 'add', 'provider'],
    runInShell: true,
  );

  Process.runSync(
    'flutter',
    ['pub', 'add', 'get_it'],
    runInShell: true,
  );

  if (routeType == 'gorouter') {
    Process.runSync(
      'flutter',
      ['pub', 'add', 'go_router'],
      runInShell: true,
    );
  }

  /// =========================
  /// Create DI
  /// =========================

  File('$root/lib/core/di/injection.dart')
    ..createSync(recursive: true)
    ..writeAsStringSync('''
import 'package:get_it/get_it.dart';

// @provider_cli-di-import

final getIt = GetIt.instance;

void setupDI() {
  // @provider_cli-di-insert
}
''');

  /// =========================
  /// Create Routing Files
  /// =========================

  if (enableRouting) {
    Directory('$root/lib/core/routes').createSync(recursive: true);

    /// =========================
    /// GoRouter Setup
    /// =========================

    if (routeType == 'gorouter') {
      File('$root/lib/core/routes/app_routes.dart')
        ..createSync(recursive: true)
        ..writeAsStringSync('''
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// @provider_cli-route-import

final appRouter = GoRouter(
  routes: [
    // @provider_cli-go-route-insert
  ],
);
''');

      print('✅ GoRouter setup added');
    }

    /// =========================
    /// Flutter Default Routes
    /// =========================

    else {
      File('$root/lib/core/routes/app_routes.dart')
        ..createSync(recursive: true)
        ..writeAsStringSync('''
import 'package:flutter/material.dart';

// @provider_cli-route-import

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    // @provider_cli-default-route-insert
  };
}
''');

      print('✅ Default Navigator routing setup added');
    }
  }

  /// =========================
  /// Main file
  /// =========================

  final mainFile = File('$root/lib/main.dart');

  if (!mainFile.existsSync()) {
    print('❌ main.dart not found');
    return;
  }

  String materialAppContent = '';

  /// =========================
  /// GoRouter MaterialApp
  /// =========================

  if (routeType == 'gorouter') {
    materialAppContent = '''
MaterialApp.router(
  debugShowCheckedModeBanner: false,
  routerConfig: appRouter,
)
''';
  }

  /// =========================
  /// Default Routes MaterialApp
  /// =========================

  else if (routeType == 'default') {
    materialAppContent = '''
MaterialApp(
  debugShowCheckedModeBanner: false,
  routes: AppRoutes.routes,
)
''';
  }

  /// =========================
  /// Normal MaterialApp
  /// =========================

  else {
    materialAppContent = '''
MaterialApp(
  debugShowCheckedModeBanner: false,
  home: const Scaffold(),
)
''';
  }

  /// =========================
  /// Route Import
  /// =========================

  String routeImport = '';

  if (enableRouting) {
    routeImport = "import 'core/routes/app_routes.dart';";
  }

  /// =========================
  /// Write main.dart
  /// =========================

  mainFile.writeAsStringSync('''
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/di/injection.dart';
$routeImport

// @provider_cli-main-import

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
        // @provider_cli-provider-insert
      ],
      child: $materialAppContent,
    );
  }
}
''');

  print('\n✅ Project initialized successfully');
}
