import 'argument_parser.dart';

/*

Example of usage:
dart lib/main.dart -V -h --version --name Martin -t dart,python,java

 */
Future<void> main(List<String> args) async {
  Arguments.parse(args).then((args) {
    print("Verbose: ${args.isVerbose}");
    print("Version: ${args.showVersion}");
    print("Help: ${args.showHelp}");
    print("Name: ${args.name}");
    print("Tags: ${args.tags}");
  }, onError: (error) {
    if (error is FormatException) {
      print(error.message);
      print("\nUsage:");
      print(Arguments.usage);
      return;
    }
    print(error);
  });
}
