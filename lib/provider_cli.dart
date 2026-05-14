import 'package:args/args.dart';

import 'commands/create_feature_command.dart';
import 'commands/init_command.dart';

/// Entry point for CLI logic
Future<void> runCLI(List<String> args) async {
  final parser = ArgParser();

  parser.addCommand('init');

  parser.addCommand('create');

  /// =========================
  /// Version Flag
  /// =========================

  parser.addFlag(
    'version',
    abbr: 'v',
    negatable: false,
    help: 'Show package version',
  );

  final result = parser.parse(args);

  try {
    /// =========================
    /// Version Command
    /// =========================

    if (result['version'] == true) {
      print('provider_cli 0.0.3');
      return;
    }

    switch (result.command?.name) {
      /// =========================
      /// Init Command
      /// =========================

      case 'init':
        runInit();
        break;

      /// =========================
      /// Create Command
      /// =========================

      case 'create':
        final subArgs = result.command!.arguments;

        if (subArgs.isEmpty) {
          print(
            '❌ Missing subcommand (feature)',
          );

          return;
        }

        /// =========================
        /// Create Feature
        /// =========================

        if (subArgs[0] == 'feature') {
          if (subArgs.length < 2) {
            print(
              '❌ Feature name required',
            );

            return;
          }

          await runCreateFeature(
            subArgs[1],
          );
        }

        break;

      /// =========================
      /// Default Help
      /// =========================

      default:
        print('''
🚀 Provider CLI

Usage:
  provider_cli init
  provider_cli create feature <name>

Options:
  --version, -v    Show package version
''');
    }
  } catch (e) {
    print('❌ Error: $e');
  }
}
