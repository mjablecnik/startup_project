import 'package:flutter/material.dart';
import 'package:design_package_template/theme/dark_mode.dart';
import 'package:design_package_template/theme/light_mode.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';
import 'package:stack_trace/stack_trace.dart' as stacktrace;

import 'design/buttons/simple_button.stories.dart';

String goldenTestPathBuilder(c) {
  List<String> path = stacktrace.Frame.caller(1).library.split('/');
  path = path.sublist(2, path.length - 1);
  final componentPath = path.join('/');
  final useCasePath = (c.path as String).split('/').fold(
    [],
    (p, e) => path.contains(e) ? p : p
      ..add(e),
  ).join('/');
  return "${c.rootPath}/$componentPath/golden_tests/$useCasePath/${c.file}";
}

Storybook storybook([List<Story>? stories]) {
  return Storybook(
    wrapperBuilder: (context, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        builder: defaultMediaQueryBuilder,
        home: Scaffold(
          body: Center(
            child: child,
          ),
        ),
      );
    },
    plugins: initializePlugins(
      enableCodeView: false,
      enableDirectionality: false,
      enableTimeDilation: false,
      initialDeviceFrameData: (
        isFrameVisible: true,
        device: Devices.ios.iPhone12ProMax,
        orientation: Orientation.portrait,
      ),
    ),
    initialStory: stories?.first.name,
    stories: stories ??
        [
          ...simpleButtonStories,
        ],
  );
}

void main() => runApp(storybook());
