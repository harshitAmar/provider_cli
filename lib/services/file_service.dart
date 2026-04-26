import 'dart:io';

void createFile(String path, String content) {
  final file = File(path);
  file.createSync(recursive: true);
  file.writeAsStringSync(content);
}

void insertIntoFile({
  required String filePath,
  required String marker,
  required String content,
}) {
  final file = File(filePath);
  if (!file.existsSync()) return;

  final text = file.readAsStringSync();

  if (text.contains(content)) return;

  final updated = text.replaceFirst(marker, '$content\n$marker');

  file.writeAsStringSync(updated);
}
