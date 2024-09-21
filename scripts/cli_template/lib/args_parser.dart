import 'package:args/args.dart';

class Arguments {
  final bool isVerbose;
  final bool showHelp;
  final bool showVersion;
  final String? name;
  final List<String>? tags;

  const Arguments({
    required this.showVersion,
    required this.showHelp,
    required this.isVerbose,
    required this.name,
    required this.tags,
  });

  static ArgParser _parser() {
    return ArgParser()
      ..addOption(
        'name',
        abbr: 'n',
        help: 'Setup name.',
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

  static Future<Arguments> parse(List<String> arguments) async {
    final ArgParser argParser = _parser();
    try {
      final ArgResults results = argParser.parse(arguments);

      return Arguments(
        showHelp: results.wasParsed('help'),
        isVerbose: results.wasParsed('verbose'),
        showVersion: results.wasParsed('version'),
        name: results.wasParsed('name') ? results.option('name') : null,
        tags: results.wasParsed('tags') ? results.multiOption('tags') : null,
      );

    } on FormatException catch (e) {
      rethrow;
    }
  }
}

