import 'package:args/args.dart';
import 'package:provider_cli/commands/init_command.dart';
import 'package:provider_cli/commands/create_feature_command.dart';

void main(List<String> args) {
  final parser = ArgParser();

  parser.addCommand('init');
  parser.addCommand('create');

  final result = parser.parse(args);

  if (result.command?.name == 'init') {
    runInit();
  } else if (result.command?.name == 'create') {
    final subArgs = result.command!.arguments;

    if (subArgs[0] == 'feature') {
      final name = subArgs[1];
      runCreateFeature(name);
    }
  } else {
    print('Usage: mycli init | mycli create feature <name>');
  }
}
