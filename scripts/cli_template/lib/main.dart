import 'package:cli_template/app_info.dart';

import 'args_parser.dart';

/*

Example of usage:
dart lib/main.dart -V --name Martin -t dart,python,java -d 'This is my description'

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
      print("Description: ${args.description}");
      print("Tags: ${args.tags}");
    }
  }, onError: (error) {
    print(error.message);
    showHelp();
    return;
  });
}

showHelp() {
  print("\nUsage:");
  print(Arguments.usage);
}
