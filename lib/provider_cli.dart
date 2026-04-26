import 'package:args/args.dart';

import 'commands/create_feature_command.dart';
import 'commands/init_command.dart';

/// Entry point for CLI logic
void runCLI(List<String> args) {
  final parser = ArgParser();

  parser.addCommand('init');
  parser.addCommand('create');

  final result = parser.parse(args);

  try {
    switch (result.command?.name) {
      case 'init':
        runInit();
        break;

      case 'create':
        final subArgs = result.command!.arguments;

        if (subArgs.isEmpty) {
          print('❌ Missing subcommand (feature)');
          return;
        }

        if (subArgs[0] == 'feature') {
          if (subArgs.length < 2) {
            print('❌ Feature name required');
            return;
          }

          runCreateFeature(subArgs[1]);
        }
        break;

      default:
        print('Usage: provider_cli init | provider_cli create feature <name>');
    }
  } catch (e) {
    print('❌ Error: $e');
  }
}
