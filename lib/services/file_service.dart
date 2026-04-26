import 'dart:io';

/// Creates file safely (won’t overwrite unless forced)
void createFile(String path, String content) {
  final file = File(path);

  if (file.existsSync()) {
    print('⚠️ File already exists: $path');
    return;
  }

  file.createSync(recursive: true);
  file.writeAsStringSync(content);
}

/// Inserts content using marker (safe injection)
void insertIntoFile({
  required String filePath,
  required String marker,
  required String content,
}) {
  final file = File(filePath);

  if (!file.existsSync()) {
    print('⚠️ File not found: $filePath');
    return;
  }

  final text = file.readAsStringSync();

  /// Prevent duplicate insert
  if (text.contains(content)) {
    print('⚠️ Already inserted in $filePath');
    return;
  }

  if (!text.contains(marker)) {
    print('⚠️ Marker not found in $filePath');
    return;
  }

  final updated = text.replaceFirst(marker, '$content\n$marker');

  file.writeAsStringSync(updated);
}
