/// Converts snake_case → PascalCase
String toPascalCase(String input) {
  return input
      .split('_')
      .where((e) => e.isNotEmpty)
      .map((e) => e[0].toUpperCase() + e.substring(1))
      .join();
}
