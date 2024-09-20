import 'package:flutter/widgets.dart';
import 'package:design_package_template/storybook.dart';

import 'simple_button/simple_button.stories.dart';

final buttonsStories = [
  ...simpleButtonStories,
];

void main() => runApp(storybook(buttonsStories));
