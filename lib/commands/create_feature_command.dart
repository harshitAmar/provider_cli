import 'dart:io';
import 'dart:isolate';

import '../services/file_service.dart';
import '../services/naming_service.dart';
import '../services/template_service.dart';

/// Generates a full module with clean architecture
Future<void> runCreateFeature(String name) async {
  /// =========================
  /// User Project Root
  /// =========================

  final root = Directory.current.path;

  final pascal = toPascalCase(name);

  final base = '$root/lib/modules/$name';

  /// =========================
  /// Resolve Template Paths
  /// =========================

  Future<String> resolveTemplate(String fileName) async {
    final uri = await Isolate.resolvePackageUri(
      Uri.parse(
        'package:provider_cli/assets/templates/$fileName',
      ),
    );

    if (uri == null) {
      throw Exception('Template not found: $fileName');
    }

    return uri.toFilePath();
  }

  final screenTemplate = await resolveTemplate('screen.tpl');

  final controllerTemplate = await resolveTemplate('controller.tpl');

  final modelTemplate = await resolveTemplate('model.tpl');

  final repoTemplate = await resolveTemplate('repo.tpl');

  final implTemplate = await resolveTemplate('impl.tpl');

  print('📁 User Project: $root');

  /// =========================
  /// Create folders
  /// =========================

  Directory('$base/view/screens').createSync(recursive: true);

  Directory('$base/view/widgets').createSync(recursive: true);

  Directory('$base/data/model').createSync(recursive: true);

  Directory('$base/data/repository').createSync(recursive: true);

  Directory('$base/data/implementation').createSync(recursive: true);

  Directory('$base/controller').createSync(recursive: true);

  /// =========================
  /// Generate files
  /// =========================

  createFile(
    '$base/view/screens/${name}_screen.dart',
    TemplateService.render(
      screenTemplate,
      {'name': pascal},
    ),
  );

  createFile(
    '$base/controller/${name}_controller.dart',
    TemplateService.render(
      controllerTemplate,
      {'name': pascal},
    ),
  );

  createFile(
    '$base/data/model/${name}_model.dart',
    TemplateService.render(
      modelTemplate,
      {'name': pascal},
    ),
  );

  createFile(
    '$base/data/repository/${name}_repository.dart',
    TemplateService.render(
      repoTemplate,
      {'name': pascal},
    ),
  );

  createFile(
    '$base/data/implementation/${name}_repository_impl.dart',
    TemplateService.render(
      implTemplate,
      {
        'name': pascal,
        'file_name': name,
      },
    ),
  );

  /// =========================
  /// Main Imports
  /// =========================

  insertIntoFile(
    filePath: '$root/lib/main.dart',
    marker: '// @provider_cli-main-import',
    content: "import 'modules/$name/controller/${name}_controller.dart';",
  );

  /// =========================
  /// Provider Injection
  /// =========================

  insertIntoFile(
    filePath: '$root/lib/main.dart',
    marker: '// @provider_cli-provider-insert',
    content: 'ChangeNotifierProvider(create: (_) => ${pascal}Controller()),',
  );

  /// =========================
  /// DI Imports
  /// =========================

  insertIntoFile(
    filePath: '$root/lib/core/di/injection.dart',
    marker: '// @provider_cli-di-import',
    content:
        "import '../../modules/$name/data/repository/${name}_repository.dart';",
  );

  insertIntoFile(
    filePath: '$root/lib/core/di/injection.dart',
    marker: '// @provider_cli-di-import',
    content:
        "import '../../modules/$name/data/implementation/${name}_repository_impl.dart';",
  );

  /// =========================
  /// DI Injection
  /// =========================

  insertIntoFile(
    filePath: '$root/lib/core/di/injection.dart',
    marker: '// @provider_cli-di-insert',
    content:
        'getIt.registerLazySingleton<${pascal}Repository>(() => ${pascal}RepositoryImpl());',
  );

  /// =========================
  /// Route Detection
  /// =========================

  final routeFile = File('$root/lib/core/routes/app_routes.dart');

  if (routeFile.existsSync()) {
    final routeContent = routeFile.readAsStringSync();

    /// =========================
    /// Screen Import
    /// =========================

    insertIntoFile(
      filePath: routeFile.path,
      marker: '// @provider_cli-route-import',
      content: "import '../../modules/$name/view/screens/${name}_screen.dart';",
    );

    /// =========================
    /// GoRouter
    /// =========================

    if (routeContent.contains(
      '// @provider_cli-go-route-insert',
    )) {
      insertIntoFile(
        filePath: routeFile.path,
        marker: '// @provider_cli-go-route-insert',
        content: '''
GoRoute(
  path: '/$name',
  name: '$name',
  builder: (context, state) => const ${pascal}Screen(),
),
''',
      );

      print('✅ GoRouter route added');
    }

    /// =========================
    /// Flutter Default Routes
    /// =========================

    else if (routeContent.contains(
      '// @provider_cli-default-route-insert',
    )) {
      insertIntoFile(
        filePath: routeFile.path,
        marker: '// @provider_cli-default-route-insert',
        content: '''
'/$name': (context) => const ${pascal}Screen(),
''',
      );

      print('✅ Default route added');
    }
  }

  print('✅ Feature "$name" created successfully');
}
