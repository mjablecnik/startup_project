import 'package:args/args.dart';
import 'package:cli_template/core.dart';

enum CommandType { option, multipleOption, flag }

enum Commands {
  name(abbr: 'n', isMandatory: true, commandType: CommandType.option, commandHelp: 'Setup name.'),
  description(abbr: 'd', isMandatory: true, commandType: CommandType.option, commandHelp: 'Setup description.'),
  tags(abbr: 't', commandType: CommandType.multipleOption, commandHelp: 'Setup tags.'),

  help(abbr: 'h', commandType: CommandType.flag, commandHelp: 'Print this usage information.'),
  verbose(abbr: 'V', commandType: CommandType.flag, commandHelp: 'Show additional command output.'),
  version(abbr: 'v', commandType: CommandType.flag, commandHelp: 'Print the tool version.'),
  ;

  const Commands({
    this.abbr,
    this.isMandatory = false,
    required this.commandHelp,
    required this.commandType,
  });

  final String? abbr;
  final bool isMandatory;
  final String commandHelp;
  final CommandType commandType;
}

class Arguments {
  final bool isVerbose;
  final bool showHelp;
  final bool showVersion;
  final String? name;
  final String? description;
  final List<String>? tags;

  const Arguments({
    required this.showVersion,
    required this.showHelp,
    required this.isVerbose,
    required this.name,
    required this.description,
    required this.tags,
  });

  static ArgParser _parser() {
    final argParser = ArgParser();
    for (var value in Commands.values) {
      switch (value.commandType) {
        case CommandType.option:
          argParser.addOption(value.name, abbr: value.abbr, mandatory: value.isMandatory, help: value.commandHelp);
        case CommandType.multipleOption:
          argParser.addMultiOption(value.name, abbr: value.abbr, help: value.commandHelp);
        case CommandType.flag:
          argParser.addFlag(value.name, abbr: value.abbr, help: value.commandHelp);
      }
    }
    return argParser;
  }

  static get usage => _parser().usage;

  static _getOptionOrNull(ArgResults results, {required String option}) {
    return results.wasParsed(option) ? results.option(option) : null;
  }

  static _getMultiOptionOrNull(ArgResults results, {required String option}) {
    return results.wasParsed(option) ? results.multiOption(option) : null;
  }

  static _getOptionOrThrowException(ArgResults results, {required String option, String? errorMessage}) {
    if (results.wasParsed(option)) {
      return results.option(option);
    } else {
      throw MissingOptionException(message: errorMessage ?? 'Missing option: \'$option\'');
    }
  }

  static Future<Arguments> parse(List<String> arguments) async {
    final ArgResults results = _parser().parse(arguments);
    return Arguments(
      showHelp: results.wasParsed(Commands.help.name),
      isVerbose: results.wasParsed(Commands.verbose.name),
      showVersion: results.wasParsed(Commands.version.name),
      name: _getOptionOrNull(results, option: Commands.name.name),
      description: _getOptionOrThrowException(results, option: Commands.description.name),
      tags: _getMultiOptionOrNull(results, option: Commands.tags.name),
    );
  }
}
