import 'dart:io';

import '../services/file_service.dart';
import '../services/naming_service.dart';
import '../services/template_service.dart';

void runCreateFeature(String name) {
  final pascal = toPascalCase(name);
  final base = 'lib/modules/$name';

  /// 📁 Create folders
  Directory('$base/view/screens').createSync(recursive: true);
  Directory('$base/view/widgets').createSync(recursive: true);
  Directory('$base/data/model').createSync(recursive: true);
  Directory('$base/data/repository').createSync(recursive: true);
  Directory('$base/data/impl').createSync(recursive: true);
  Directory('$base/controller').createSync(recursive: true);

  /// 📄 Generate files using templates

  createFile(
    '$base/view/screens/${name}_screen.dart',
    TemplateService.render('lib/templates/screen.tpl', {'name': pascal}),
  );

  createFile(
    '$base/controller/${name}_controller.dart',
    TemplateService.render('lib/templates/controller.tpl', {'name': pascal}),
  );

  createFile(
    '$base/data/model/${name}_model.dart',
    TemplateService.render('lib/templates/model.tpl', {'name': pascal}),
  );

  createFile(
    '$base/data/repository/${name}_repository.dart',
    TemplateService.render('lib/templates/repo.tpl', {'name': pascal}),
  );

  createFile(
    '$base/data/impl/${name}_impl.dart',
    TemplateService.render('lib/templates/impl.tpl', {
      'name': pascal,
      'file_name': name,
    }),
  );

  /// 🔌 Insert Provider

  insertIntoFile(
    filePath: 'lib/main.dart',
    marker: '// @mycli-provider-insert',
    content: 'ChangeNotifierProvider(create: (_) => ${pascal}Controller()),',
  );

  /// 🔌 Insert DI

  insertIntoFile(
    filePath: 'lib/core/di/injection.dart',
    marker: '// @mycli-di-insert',
    content:
        'getIt.registerLazySingleton<${pascal}Repository>(() => ${pascal}RepositoryImpl());',
  );

  print('Feature $name created successfully');
}
