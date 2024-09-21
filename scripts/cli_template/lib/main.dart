import 'package:cli_template/app_info.dart';

import 'argument_parser.dart';

/*

Example of usage:
dart lib/main.dart -V --name Martin -t dart,python,java

 */
void main(List<String> args) {
  Arguments.parse(args).then((args) async {
    if (args.showHelp) {
      showHelp();
    } else if (args.showVersion) {
      print("Version: ${await AppInfo().version}");
    } else {
      print("Verbose: ${args.isVerbose}");
      print("Name: ${args.name}");
      print("Tags: ${args.tags}");
    }
  }, onError: (error) {
    if (error is FormatException) {
      print(error.message);
      showHelp();
      return;
    }
    print(error);
  });
}


showHelp() {
  print("\nUsage:");
  print(Arguments.usage);
}