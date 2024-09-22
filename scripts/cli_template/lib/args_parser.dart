import 'package:args/args.dart';
import 'package:cli_template/core.dart';

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
    return ArgParser()
      ..addOption(
        'name',
        abbr: 'n',
        help: 'Setup name.',
      )
      ..addOption(
        'description',
        abbr: 'd',
        mandatory: true,
        help: 'Setup description.',
      )
      ..addMultiOption(
        'tags',
        abbr: 't',
        help: 'Setup tags.',
      )
      ..addFlag(
        'help',
        abbr: 'h',
        negatable: false,
        help: 'Print this usage information.',
      )
      ..addFlag(
        'verbose',
        abbr: 'V',
        negatable: false,
        help: 'Show additional command output.',
      )
      ..addFlag(
        'version',
        abbr: 'v',
        negatable: false,
        help: 'Print the tool version.',
      );
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
      showHelp: results.wasParsed('help'),
      isVerbose: results.wasParsed('verbose'),
      showVersion: results.wasParsed('version'),
      name: _getOptionOrNull(results, option: 'name'),
      description: _getOptionOrThrowException(results, option: 'description'),
      tags: _getMultiOptionOrNull(results, option: 'tags'),
    );
  }
}
