import 'dart:io';

import 'package:provider_cli/services/file_service.dart';
import 'package:provider_cli/services/naming_service.dart';
import 'package:provider_cli/services/template_service.dart';
import 'package:test/test.dart';

void main() {
  group('Naming Service Tests', () {
    test('toPascalCase converts snake_case correctly', () {
      expect(toPascalCase('auth'), 'Auth');
      expect(toPascalCase('auth_profile'), 'AuthProfile');
      expect(toPascalCase('user_data_test'), 'UserDataTest');
    });

    test('toPascalCase handles empty or malformed input', () {
      expect(toPascalCase(''), '');
      expect(toPascalCase('_auth'), 'Auth');
      expect(toPascalCase('auth_'), 'Auth');
    });
  });

  group('File Service Tests', () {
    late Directory tempDir;

    setUp(() {
      tempDir = Directory.systemTemp.createTempSync();
    });

    tearDown(() {
      tempDir.deleteSync(recursive: true);
    });

    test('createFile creates a new file with content', () {
      final filePath = '${tempDir.path}/test.txt';

      createFile(filePath, 'Hello World');

      final file = File(filePath);
      expect(file.existsSync(), true);
      expect(file.readAsStringSync(), 'Hello World');
    });

    test('createFile does not overwrite existing file', () {
      final filePath = '${tempDir.path}/test.txt';

      createFile(filePath, 'First');
      createFile(filePath, 'Second');

      final file = File(filePath);
      expect(file.readAsStringSync(), 'First');
    });

    test('insertIntoFile inserts content at marker', () {
      final filePath = '${tempDir.path}/test.dart';

      File(filePath).writeAsStringSync('''
void main() {
  // @marker
}
''');

      insertIntoFile(
        filePath: filePath,
        marker: '// @marker',
        content: 'print("Hello");',
      );

      final updated = File(filePath).readAsStringSync();

      expect(updated.contains('print("Hello");'), true);
    });

    test('insertIntoFile prevents duplicate insertion', () {
      final filePath = '${tempDir.path}/test.dart';

      File(filePath).writeAsStringSync('''
// @marker
''');

      insertIntoFile(
        filePath: filePath,
        marker: '// @marker',
        content: 'print("Hello");',
      );

      insertIntoFile(
        filePath: filePath,
        marker: '// @marker',
        content: 'print("Hello");',
      );

      final updated = File(filePath).readAsStringSync();

      final count = RegExp('print\\("Hello"\\);').allMatches(updated).length;

      expect(count, 1);
    });
  });

  group('Template Service Tests', () {
    late Directory tempDir;

    setUp(() {
      tempDir = Directory.systemTemp.createTempSync();
    });

    tearDown(() {
      tempDir.deleteSync(recursive: true);
    });

    test('Template renders variables correctly', () {
      final templateFile = File('${tempDir.path}/template.tpl');

      templateFile.writeAsStringSync('Hello {{name}}');

      final result = TemplateService.render(
        templateFile.path,
        {'name': 'Amarjeet'},
      );

      expect(result, 'Hello Amarjeet');
    });

    test('Template throws error if file not found', () {
      expect(
        () => TemplateService.render('invalid.tpl', {}),
        throwsException,
      );
    });
  });
}
