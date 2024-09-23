import 'dart:io';

import 'package:cli_template/app_info.dart';
import 'package:cli_template/args_parser.dart';


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
    try {
      print(error.message);
      showHelp();
    } catch (e) {
      print("$error\n");
      stdout.write(error.stackTrace);
    }
  });
}

showHelp() {
  print("\nUsage:");
  print(Arguments.usage);
}
