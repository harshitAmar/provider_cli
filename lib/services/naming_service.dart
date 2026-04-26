String toPascalCase(String input) {
  return input
      .split('_')
      .map((e) => e[0].toUpperCase() + e.substring(1))
      .join();
}
