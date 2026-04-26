import 'dart:io';

class TemplateService {
  static String render(String templatePath, Map<String, String> values) {
    final file = File(templatePath);

    if (!file.existsSync()) {
      throw Exception('Template not found: $templatePath');
    }

    String content = file.readAsStringSync();

    values.forEach((key, value) {
      content = content.replaceAll('{{$key}}', value);
    });

    return content;
  }
}
